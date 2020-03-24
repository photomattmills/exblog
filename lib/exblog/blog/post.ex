defmodule Exblog.Blog.Post do
  use Ecto.Schema
  import Ecto.Changeset

  schema "posts" do
    field :body, :string
    field :description, :string
    field :og_image, :string
    field :slug, :string
    field :title, :string

    timestamps()
  end

  @doc false
  def changeset(post, attrs) do
    post
    |> cast(attrs, [:title, :og_image, :description, :body, :slug])
    |> validate_required([:title, :body])
    |> add_slug_to_changeset()
  end

  defp add_slug_to_changeset(changeset = %{valid?: false}), do: changeset

  defp add_slug_to_changeset(changeset = %{changes: %{title: title}}) do
    slug = String.downcase(title) |> String.replace(" ", "_")
    put_change(changeset, :slug, slug)
  end

  defp add_slug_to_changeset(changeset), do: changeset
end
