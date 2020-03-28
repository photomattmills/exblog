defmodule ExblogWeb.ImageController do
  use ExblogWeb, :controller
  alias Exblog.Repo
  alias Exblog.Blog.Image

  def create(conn, params) do
    path = "#{params["post_id"]}/#{params["image"].filename}"
    uploader().upload(params["image"], path)
    {:ok, image} = Repo.insert(%Image{post_id: params["post_id"], url: "https://images.matt.pictures/#{path}"})

    resp_json = Jason.encode!(%{id: image.id, url: image.url})

    conn
    |> put_resp_header("location", Routes.post_path(conn, :edit, params["post_id"]))
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

  def uploader do
    Application.get_env(:exblog, :image_uploader, Exblog.ImageUploader)
  end
end
