defmodule ExblogWeb.PostLive.Index do
  use ExblogWeb, :live_view

  alias Exblog.Repo
  alias Exblog.Blog
  alias Exblog.Blog.Post
  alias Exblog.Blog.Image

  @impl true
  def mount(_params, _session, socket) do
    socket = socket
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
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :edit, %{"id" => id}) do
    post = Blog.get_post!(id)
    socket
    |> assign(:page_title, "Edit Post")
    |> assign(:published, !!post.published_at)
    |> assign(:form, to_form(Ecto.Changeset.change(post)))
    |> assign(:post, post)
  end

  defp apply_action(socket, :new, _params) do
    socket
    |> assign(:page_title, "New Post")
    |> assign(:post, %Post{})
    |> assign(:form, to_form(%Post{}))
    |> assign(:published, false)
    |> assign(:changeset, Ecto.Changeset.change(%Post{}))
  end

  @impl true
  def handle_info({ExblogWeb.PostLive.Edit, {:saved, post}}, socket) do
    {:noreply, stream_insert(socket, :posts, post)}
  end

  def handle_event("save", params, socket) do
    case Blog.update_post(socket.assigns.post, params["post"]) do
      {:ok, post} ->
        IO.puts("SAVED")
        {
          :noreply,
          socket
          |> assign(:post, post)
          |> assign(:published, !!post.published_at)
        }

        {:error, %Ecto.Changeset{} = changeset} ->
        IO.puts("erroe")
        IO.inspect(changeset)
        {:noreply, assign(socket, :changeset, changeset)}
    end
  end

  @impl true
  def handle_event("delete", %{"id" => id}, socket) do
    post = Blog.get_post!(id)
    {:ok, _} = Blog.delete_post(post)

    {:noreply, stream_delete(socket, :posts, post)}
  end

  @impl true
  def handle_event("validate", _params, socket) do
    {:noreply, socket}
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
       |> assign(:form, to_form(Ecto.Changeset.change(saved_post)))}
    else
      {:noreply, socket}
    end
  end

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
    |> Enum.sort()
    |> Enum.join("")
  end

  defp base_url, do: Application.get_env(:exblog, :s3_base_url)

end
