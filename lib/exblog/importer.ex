defmodule Exblog.Importer do
  alias Exblog.Repo
  alias Exblog.Blog.Post
  alias Exblog.Blog.Image
  alias Exblog.Blog

  import Meeseeks.XPath

  def import(url, site_id) do
    http_get_body!(url)
    |> Meeseeks.all(xpath("item"))
    |> Enum.each(fn post -> import_post(post, site_id) end)
  end

  def import_post(post, site_id) do
    title = extract_text(post, "title")
    published_at = extract_text(post, "pubdate")
    post_body = extract_text(post, "description")

    {:ok, local_post} = Repo.insert(%Post{})

    moved_images =
      extract_images(post_body)
      |> move_images_to_s3(local_post.id)

    new_post_body =
      Enum.reduce(moved_images, post_body, fn images, body ->
        String.replace(body, images.original.url, images.new.url)
      end)

    IO.write(".")

    Blog.update_post(local_post, %{
      body: new_post_body,
      title: title,
      published_at: published_at,
      site_id: site_id
    })
  end

  defp extract_text(post, key), do: Meeseeks.one(post, xpath(key)) |> Meeseeks.text()

  defp extract_images(post_body) do
    post_body
    |> Meeseeks.parse()
    |> Meeseeks.all(xpath("img"))
    |> Enum.map(fn img_tag ->
      %{url: Meeseeks.attr(img_tag, "src"), caption: Meeseeks.attr(img_tag, "alt")}
    end)
  end

  defp move_images_to_s3(images, post_id) do
    images |> Enum.map(fn image -> move_image_to_s3(image, post_id) end)
  end

  defp move_image_to_s3(image, post_id) do
    with {:ok, body} <- http_get_body(image.url),
         filename <- get_filename_from_url(image.url),
         _ <- File.write(tmp_file_path(filename), body) do
      path = "#{post_id}/#{filename}"
      uploader().upload(tmp_file_path(filename), path)

      {:ok, repo_image} =
        Repo.insert(%Image{post_id: post_id, url: "https://images.matt.pictures/#{path}"})

      File.rm(tmp_file_path(filename))
      %{original: image, new: repo_image}
    else
      something -> IO.inspect(something, label: "error!")
    end
  end

  def tmp_file_path(filename), do: "/tmp/#{filename}"

  defp get_filename_from_url(url) do
    URI.parse(url).path
    |> String.split("/")
    |> Enum.at(-1)
  end

  defp uploader do
    Application.get_env(:exblog, :image_uploader, Exblog.ImageUploader)
  end

  defp http_get_body(url) do
    {:ok, 200, _headers, client_ref} = :hackney.get(url, [], "", follow_redirect: true)
    :hackney.body(client_ref)
  end

  defp http_get_body!(url) do
    {:ok, body} = http_get_body(url)
    body
  end
end
