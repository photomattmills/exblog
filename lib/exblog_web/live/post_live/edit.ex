defmodule ExblogWeb.PostLive.Edit do
  use ExblogWeb, :live_view
  require Logger

  alias Exblog.Blog
  alias Exblog.Blog.Image
  alias Exblog.Repo

  @impl true
  def mount(_params, _session, socket) do
    socket =
      socket
      |> assign(:site, ExblogWeb.SitePlug.default_site())
      |> assign(:uploaded_files, [])
      |> allow_upload(:photo,
        accept: ~w(.jpeg .jpg),
        auto_upload: true,
        progress: &handle_progress/3,
        max_file_size: 5_000_000,
        max_entries: 50
      )

    {:ok, socket}
  end

  @impl true
  def handle_params(%{"id" => id}, _, socket) do
    post = Blog.get_post!(id)

    {:noreply,
     socket
     |> assign(:page_title, page_title("Editing: #{post.title}"))
     |> assign(:post, post)
     |> assign(:published, !!post.published_at)
     |> assign(:changeset, Blog.change_post(post))}
  end

  @impl true
  def handle_event("validate", _params, socket) do
    {:noreply, socket}
  end

  def handle_event("save", %{"post" => post_params}, socket) do
    case Blog.update_post(socket.assigns.post, post_params) do
      {:ok, post} ->
        {:noreply,
         socket
         |> assign(:post, post)
         |> assign(:published, !!post.published_at)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, :changeset, changeset)}
    end
  end

  def handle_progress(:photo, entry, socket) do
    if(entry.done?) do
      repo_image =
        consume_uploaded_entry(socket, entry, fn %{path: path} ->
          {:ok, save_and_upload_image(path, entry.client_name, socket.assigns.post.id)}
        end)

      post = socket.assigns.post
      image_addons = post_update([repo_image])
      new_body = post.body <> image_addons
      {:ok, saved_post} = Blog.update_post(post, %{body: new_body})

      {:noreply,
       socket
       |> assign(:post, saved_post)
       |> assign(:changeset, Blog.change_post(post, %{body: new_body}))}
    else
      {:noreply, socket}
    end
  end

  defp page_title(_), do: ""

  defp uploader do
    Application.get_env(:exblog, :image_uploader, Exblog.ImageUploader)
  end

  defp save_and_upload_image(image_path, filename, post_id) do
    path = "#{post_id}/#{filename}"
    uploader().upload(image_path, path)
    Repo.insert!(%Image{post_id: post_id, url: "#{base_url()}/#{path}"})
  end

  def post_update(images) do
    Enum.map(images, fn repo_image ->
      "\n# ![#{repo_image.caption}](#{repo_image.url})"
    end)
    |> Enum.join("")
  end

  defp base_url, do: Application.get_env(:exblog, :s3_base_url)
end
