defmodule ExblogWeb.PostController do
  use ExblogWeb, :controller

  alias Exblog.Blog
  alias Exblog.Blog.Post
  alias ExblogWeb.Router.Helpers, as: Routes

  def index(conn = %{assigns: %{site: %{root_page: root}}}, params) when is_nil(root) do
    %{posts: posts, next_page: next_page, previous_page: previous_page} =
      Blog.list_posts(String.to_integer(params["page"] || "1"), conn.assigns.site.id)

    render(
      conn,
      "index.html",
      [
        posts: posts,
        next_page: next_page,
        previous_page: previous_page
      ] ++ default_assigns(conn, posts)
    )
  end

  def index(conn = %{assigns: %{site: site = %{root_page: "grid"}}}, params) do
    %{posts: posts, next_page: next_page, previous_page: previous_page} =
      Blog.list_posts(String.to_integer(params["page"] || "1"), site.id, site.per_page)

    render(
      conn,
      "grid-index.html",
      [
        posts: posts,
        next_page: next_page,
        previous_page: previous_page
      ] ++ default_assigns(conn, posts)
    )
  end

  def rss(conn, _params) do
    posts = Blog.list_all_posts(conn.assigns.site.id)

    conn
    |> put_resp_content_type("text/xml")
    |> put_format(:xml)
    |> render("rss.xml", layout: false, posts: posts, site: conn.assigns.site)
  end

  def new(conn, _params) do
    {:ok, post} =
      Exblog.Repo.insert(%Post{
        title: "starter title",
        body: "full speed ahead",
        site_id: conn.assigns.site.id,
        user_id: conn.assigns.current_user.id
      })

    redirect(conn, to: ExblogWeb.Router.Helpers.post_edit_path(conn, :edit, post))
  end

  def admin_index(conn, _params) do
    posts = Blog.list_published_and_unpublished_posts(conn.assigns.site.id)

    render(conn, "admin_index.html", [posts: posts] ++ default_assigns(conn, posts))
  end

  def create(conn, %{"post" => post_params}) do
    case Blog.create_post(post_params) do
      {:ok, post} ->
        conn
        |> put_flash(:info, "Post created successfully.")
        |> redirect(to: ~p"/posts/#{post}")

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, :new, changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    post = Blog.get_post!(id)
    render(conn, :show, post: post)
  end

  def show_by_slug(conn, %{"post_slug" => slug}) do
    post = %{slugs: [newest | _rest]} = Blog.get_post_by_slug!(slug)

    cond do
      slug == newest ->
        render(conn, "show.html", [post: post] ++ post_assigns(post))

      true ->
        conn
        |> put_status(301)
        |> redirect(to: Routes.post_path(conn, :show_by_slug, newest))
    end
  end

  def edit(conn, %{"id" => id}) do
    post = Blog.get_post!(id)
    changeset = Blog.change_post(post)
    render(conn, :edit, post: post, changeset: changeset)
  end

  def update(conn, %{"id" => id, "post" => post_params}) do
    post = Blog.get_post!(id)

    case Blog.update_post(post, post_params) do
      {:ok, post} ->
        conn
        |> put_flash(:info, "Post updated successfully.")
        |> redirect(to: ~p"/posts/#{post}")

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, :edit, post: post, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    post = Blog.get_post!(id)
    {:ok, _post} = Blog.delete_post(post)

    conn
    |> put_flash(:info, "Post deleted successfully.")
    |> redirect(to: ~p"/posts")
  end

  defp default_assigns(conn, [first_post | _rest]) do
    [
      post_title: conn.assigns.site.title,
      post_description: conn.assigns.site.description,
      og_image: first_post.og_image
    ]
  end

  defp default_assigns(conn, []),
    do: [post_title: conn.assigns.site.title, post_description: conn.assigns.site.description]

  defp post_assigns(%{title: title, og_image: og_image, description: description}) do
    [
      post_title: title,
      post_description: description,
      og_image: og_image
    ]
  end
end
