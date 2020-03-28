defmodule ExblogWeb.ImageControllerTest do
  use ExblogWeb.ConnCase
  alias Exblog.Repo
  alias Exblog.Blog.Image

  setup %{conn: conn} do
    Application.put_env(:exblog, :image_uploader, FakeUploader)

    {:ok, post} = Exblog.Blog.create_post(%{title: "test title", body: "test body"})

    %{conn: conn, post: post}
  end

  describe "create image" do
    test "redirects to blog post edit path", %{conn: conn, post: blog_post} do
      upload = %Plug.Upload{path: "test/support/fixtures/0002.jpg", filename: "0002.jpg", content_type: "image/jpeg"}
      conn = post(conn, Routes.image_path(conn, :create), %{image: upload, caption: "this is a caption", post_id: blog_post.id})
      assert response = json_response(conn, 302)
      assert Repo.get(Image, response["id"])
      assert redirected_to(conn) == Routes.post_path(conn, :edit, blog_post.id)
    end
  end

  # describe "update image" do
  #
  #   test "redirects when data is valid", %{conn: conn, image: image} do
  #     conn = put(conn, Routes.image_path(conn, :update, image), image: @update_attrs)
  #     assert redirected_to(conn) == Routes.image_path(conn, :show, image)
  #
  #     conn = get(conn, Routes.image_path(conn, :show, image))
  #     assert html_response(conn, 200) =~ "some updated body"
  #   end
  #
  #   test "renders errors when data is invalid", %{conn: conn, image: image} do
  #     conn = put(conn, Routes.image_path(conn, :update, image), image: @invalid_attrs)
  #     assert html_response(conn, 200) =~ "Edit Post"
  #   end
  # end
  #
  # describe "delete image" do
  #   setup [:create_image]
  #
  #   test "deletes chosen image", %{conn: conn, image: image} do
  #     conn = delete(conn, Routes.post_path(conn, :delete, post))
  #     assert redirected_to(conn) == Routes.post_path(conn, :index)
  #     assert_error_sent 404, fn ->
  #       get(conn, Routes.post_path(conn, :show, post))
  #     end
  #   end
  # end
  #
  # defp create_post(_) do
  #   post = fixture(:post)
  #   {:ok, post: post}
  # end
end

defmodule FakeUploader do
  def upload(_file, _key) do
    :ok
  end
end
