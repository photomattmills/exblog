defmodule ExblogWeb.PostLive.Index do
  use ExblogWeb, :live_view

  alias Exblog.Blog
  alias Exblog.Blog.Post

  @impl true
  def mount(_params, _session, socket) do
    {:ok, assign(socket, :posts, Blog.list_posts(1, 1))}
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :edit, %{"id" => id}) do
    socket
    |> assign(:page_title, "Edit Post")
    |> assign(:post, Blog.get_post!(id))
  end

  defp apply_action(socket, :new, _params) do
    socket
    |> assign(:page_title, "New Post")
    |> assign(:post, %Post{})
  end

  defp apply_action(socket, :index, _params) do
    socket
    |> assign(:page_title, "Listing Posts")
    |> assign(:post, nil)
  end

  @impl true
  def handle_event("delete", %{"id" => id}, socket) do
    post = Blog.get_post!(id)
    {:ok, _} = Blog.delete_post(post)

    {:noreply, assign(socket, :posts, list_posts())}
  end

  defp list_posts(page \\ 1, site_id \\ 1) do
    Blog.list_posts(page, site_id)
  end
end
