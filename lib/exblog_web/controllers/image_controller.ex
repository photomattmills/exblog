defmodule ExblogWeb.ImageController do
  use ExblogWeb, :controller
  alias Exblog.{Repo, Blog}
  alias Exblog.Blog.{Image, Post}

  def create(conn, %{"image_upload" => %{"post_id" => post_id, "images" => images}}) do
    post_id = String.to_integer(post_id)

    repo_images =
      Enum.map(images, fn image ->
        path = "#{post_id}/#{image.filename}"
        uploader().upload(image.path, path)

        {:ok, repo_image} =
          Repo.insert(%Image{post_id: post_id, url: "https://images.matt.pictures/#{path}"})

        repo_image
      end)

    post_update =
      repo_images
      |> Enum.map(fn repo_image ->
        "![#{repo_image.caption}](#{repo_image.url})"
      end)
      |> Enum.join("\n")

    post = Repo.get!(Post, post_id)
    Blog.update_post(post, %{body: post.body <> post_update})

    resp_json =
      repo_images
      |> Enum.map(fn image -> %{url: image.url, id: image.id} end)
      |> Jason.encode!()

    conn
    |> put_resp_header("location", Routes.post_path(conn, :edit, post_id))
    |> put_resp_content_type("application/json")
    |> send_resp(302, resp_json)
  end

  def delete(conn, params) do
    {:ok, image} = Repo.get(Image, params["id"]) |> Repo.delete()

    with "https://images.matt.pictures/" <> key <- image.url do
      uploader().delete(key)
    end

    conn
    |> put_resp_header("location", Routes.post_path(conn, :edit, image.post_id))
    |> send_resp(302, "redirecting")
  end

  defp uploader do
    Application.get_env(:exblog, :image_uploader, Exblog.ImageUploader)
  end
end
