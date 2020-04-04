defmodule ExblogWeb.PostControllerTest do
  use ExblogWeb.ConnCase

  alias Exblog.Blog

  @create_attrs %{
    body: "some body",
    description: "some description",
    og_image: "some og_image",
    published_at: DateTime.utc_now(),
    title: "some title",
    slug: "some_title",
    site_id: 1
  }
  @update_attrs %{
    body: "some updated body",
    description: "some updated description",
    og_image: "some updated og_image",
    title: "some updated title",
    slug: "a_new_slug"
  }
  @invalid_attrs %{body: nil, description: nil, og_image: nil, title: nil}

  def fixture(:post) do
    {:ok, post} = Blog.create_post(@create_attrs)
    post
  end

  describe "index" do
    setup %{conn: conn} do
      Enum.map(0..100, fn _x -> fixture(:post) end)
      %{conn: conn}
    end

    test "lists all posts", %{conn: conn} do
      conn = get(conn, Routes.post_path(conn, :index))
      assert html_response(conn, 200)
    end

    test "has next_page link", %{conn: conn} do
      conn = get(conn, Routes.post_path(conn, :index))
      assert html_response(conn, 200) =~ "<a href=\"/page/2\">Next Page</a>"
    end

    test "has previous_page link", %{conn: conn} do
      conn = get(conn, Routes.post_path(conn, :index, page: 2))
      assert html_response(conn, 200) =~ "<a href=\"/page/1\">Previous Page</a>"
    end
  end

  describe "new post" do
    test "renders form", %{conn: conn} do
      conn = get(conn, Routes.post_path(conn, :new))
      assert html_response(conn, 302) =~ "redirected"
    end
  end

  describe "get post by slug" do
    setup [:create_post]

    test "gets a post with a slug", %{conn: conn, post: post} do
      conn = get(conn, Routes.post_path(conn, :show_by_slug, post.slug))
      assert response(conn, 200) =~ "some body"
    end
  end

  describe "edit post" do
    setup [:create_post]

    test "renders form for editing chosen post", %{conn: conn, post: post} do
      conn = get(conn, Routes.post_path(conn, :edit, post))
      assert html_response(conn, 200) =~ "Edit Post"
    end
  end

  describe "update post" do
    setup [:create_post]

    test "redirects when data is valid", %{conn: conn, post: post} do
      conn = put(conn, Routes.post_path(conn, :update, post), post: @update_attrs)
      assert redirected_to(conn) == Routes.post_path(conn, :show, post)

      conn = get(conn, Routes.post_path(conn, :show, post))
      assert html_response(conn, 200) =~ "some updated body"
    end

    test "renders errors when data is invalid", %{conn: conn, post: post} do
      conn = put(conn, Routes.post_path(conn, :update, post), post: @invalid_attrs)
      assert html_response(conn, 200) =~ "Edit Post"
    end
  end

  describe "delete post" do
    setup [:create_post]

    test "deletes chosen post", %{conn: conn, post: post} do
      conn = delete(conn, Routes.post_path(conn, :delete, post))
      assert redirected_to(conn) == Routes.post_path(conn, :index)

      assert_error_sent 404, fn ->
        get(conn, Routes.post_path(conn, :show, post))
      end
    end
  end

  defp create_post(_) do
    post = fixture(:post)
    {:ok, post: post}
  end
end
