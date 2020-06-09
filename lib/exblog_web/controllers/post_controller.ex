defmodule ExblogWeb.PostController do
  use ExblogWeb, :controller

  alias Exblog.Blog
  alias Exblog.Blog.Post
  alias Exblog.Repo

  def index(conn, params) do
    %{posts: posts, next_page: next_page, previous_page: previous_page} =
      Blog.list_posts(String.to_integer(params["page"] || "1"), conn.assigns.site.id)

    render(
      conn,
      "index.html",
      [
        posts: posts,
        post_title: "Matt's Pictures",
        next_page: next_page,
        previous_page: previous_page
      ] ++ default_assigns(posts)
    )
  end

  def rss(conn, _params) do
    posts = Blog.list_all_posts(conn.assigns.site.id)

    conn
    |> put_resp_content_type("text/xml")
    |> render("index.xml", posts: posts)
  end

  def admin_index(conn, _params) do
    posts = Blog.list_all_posts(conn.assigns.site.id)

    render(conn, "admin-index.html", [posts: posts] ++ default_assigns(posts))
  end

  def new(conn, _params) do
    # changeset = Blog.change_post(%Post{})
    # render(conn, "new.html", changeset: changeset)
    {:ok, post} = Repo.insert(%Post{})
    redirect(conn, to: Routes.post_path(conn, :edit, post))
  end

  def show(conn, %{"id" => id}) do
    post = Blog.get_post!(id)
    render(conn, "show.html", [post: post] ++ post_assigns(post))
  end

  def show_by_slug(conn, %{"post_slug" => slug}) do
    post = Blog.get_post_by_slug!(slug)
    render(conn, "show.html", [post: post] ++ post_assigns(post))
  end

  def edit(conn, %{"id" => id}) do
    post = Blog.get_post!(id)
    changeset = Blog.change_post(post)
    render(conn, "edit.html", post: post, changeset: changeset)
  end

  def update(conn, %{"id" => id, "post" => post_params}) do
    post = Blog.get_post!(id)

    case Blog.update_post(post, post_params) do
      {:ok, post} ->
        conn
        |> put_flash(:info, "Post updated successfully.")
        |> redirect(to: Routes.post_path(conn, :show, post))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", post: post, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    post = Blog.get_post!(id)
    {:ok, _post} = Blog.delete_post(post)

    conn
    |> put_flash(:info, "Post deleted successfully.")
    |> redirect(to: Routes.post_path(conn, :admin_index))
  end

  defp default_assigns([first_post | _rest]) do
    [
      post_title: "Matt's Pictures",
      post_description: "Some pictures",
      og_image: first_post.og_image
    ]
  end

  defp default_assigns([]), do: []

  defp post_assigns(%{title: title, og_image: og_image, description: description}) do
    [
      post_title: title,
      post_description: description,
      og_image: og_image
    ]
  end
end
