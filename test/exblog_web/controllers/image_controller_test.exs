defmodule ExblogWeb.ImageControllerTest do
  use ExblogWeb.ConnCase
  alias Exblog.Repo
  alias Exblog.Blog.Image
  alias Exblog.Blog.Post

  setup %{conn: conn} do
    Application.put_env(:exblog, :image_uploader, FakeUploader)

    {:ok, post} = Exblog.Blog.create_post(%{title: "test title", body: "test body"})

    %{conn: conn, post: post}
  end

  describe "create image" do
    test "redirects to blog post edit path", %{conn: conn, post: blog_post} do
      upload = %Plug.Upload{
        path: "test/support/fixtures/0002.jpg",
        filename: "0002.jpg",
        content_type: "image/jpeg"
      }

      conn =
        post(conn, Routes.image_path(conn, :create), %{
          image_upload: %{
            images: [upload],
            post_id: "#{blog_post.id}"
          }
        })

      assert response = json_response(conn, 302)
      assert Repo.get(Image, hd(response)["id"])
      assert redirected_to(conn) == Routes.post_path(conn, :edit, blog_post.id)

      assert Repo.get(Post, blog_post.id).body =~ "![](#{hd(response)["url"]})"
    end
  end

  describe "delete image" do
    test "deletes images", %{conn: conn, post: blog_post} do
      {:ok, image} = Repo.insert(%Image{url: "https://example.com", post_id: blog_post.id})

      conn = delete(conn, Routes.image_path(conn, :delete, image))

      assert nil == Repo.get(Image, image.id)

      assert response(conn, 302)
      assert redirected_to(conn) == Routes.post_path(conn, :edit, blog_post.id)
    end
  end
end
