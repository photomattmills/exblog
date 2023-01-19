defmodule ExblogWeb.PostLive.Edit do
  use ExblogWeb, :live_view

  alias Exblog.Blog

  @impl true
  def mount(_params, _session, socket) do
    socket =
      socket
      |> assign(:site, ExblogWeb.SitePlug.default_site())
      |> assign(:uploaded_files, [])
      |> allow_upload(:photo,
        accept: ~w(.jpeg .jpg),
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
    IO.puts("called validate !!!!!!!!")
    {:noreply, socket}
  end

  def handle_event("save_photos", _params, socket) do
    consume_uploaded_entries(socket, :photo, fn %{path: path}, entry ->
      IO.inspect(entry, label: "file properties")
      dest = Path.join("priv/static/uploads", entry.client_name)
      File.cp!(path, dest)
      {:ok, Routes.static_path(socket, "/uploads/#{Path.basename(dest)}")}
    end)

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

  defp page_title(_), do: ""
end
