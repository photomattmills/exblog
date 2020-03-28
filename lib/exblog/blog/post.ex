defmodule Exblog.Blog.Post do
  use Ecto.Schema
  import Ecto.Changeset
  alias Exblog.Blog.Image

  schema "posts" do
    field :body, :string
    field :description, :string
    field :og_image, :string
    field :published, :boolean, default: false
    field :slug, :string
    field :title, :string

    has_many :images, Image

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

  defp add_slug_to_changeset(changeset = %{changes: %{title: title}}) when title != nil do
    slug = String.downcase(title) |> String.replace(" ", "_")
    put_change(changeset, :slug, slug)
  end

  defp add_slug_to_changeset(changeset), do: changeset
end
