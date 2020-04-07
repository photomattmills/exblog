defmodule ExblogWeb.ImageController do
  use ExblogWeb, :controller
  alias Exblog.{Repo, Blog}
  alias Exblog.Blog.{Image, Post}

  def create(conn, %{"image_upload" => %{"post_id" => post_id, "images" => images}}) do
    post_id = String.to_integer(post_id)

    repo_images = save_and_upload_images(images, post_id)

    update_post_body(repo_images, post_id)

    conn
    |> put_resp_header("location", Routes.post_path(conn, :edit, post_id))
    |> put_resp_content_type("application/json")
    |> send_resp(302, build_response(repo_images))
  end

  def delete(conn, params) do
    with {:ok, image} <- Repo.get(Image, params["id"]) |> Repo.delete(),
         key <- String.replace(image.url, "#{base_url()}/", "") do
      uploader().delete(key)

      conn
      |> put_resp_header("location", Routes.post_path(conn, :edit, image.post_id))
      |> send_resp(302, "redirecting")
    end
  end

  defp uploader do
    Application.get_env(:exblog, :image_uploader, Exblog.ImageUploader)
  end

  defp update_post_body(images, post_id) do
    post_update =
      images
      |> Enum.map(fn repo_image ->
        "![#{repo_image.caption}](#{repo_image.url})"
      end)
      |> Enum.join("\n")

    post = Repo.get!(Post, post_id)

    Ecto.Changeset.change(post, %{body: "#{post.body}" <> post_update})
    |> Repo.update()
  end

  defp build_response(images) do
    images
    |> Enum.map(fn image -> %{url: image.url, id: image.id} end)
    |> Jason.encode!()
  end

  defp save_and_upload_images(images, post_id) do
    Enum.map(images, fn image ->
      path = "#{post_id}/#{image.filename}"
      uploader().upload(image.path, path)

      Repo.insert!(%Image{post_id: post_id, url: "#{base_url()}/#{path}"})
    end)
  end

  defp base_url, do: Application.get_env(:exblog, :s3_base_url)
end
