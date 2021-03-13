defmodule Exblog.Blog.Post do
  use Ecto.Schema
  import Ecto.Changeset
  alias Exblog.Blog.Image

  schema "posts" do
    field :body, :string
    field :buy_link, :string
    field :description, :string
    field :og_image, :string
    field :published_at, :utc_datetime
    field :slug, :string
    field :title, :string
    field :page_only, :boolean
    field :is_retail, :boolean

    belongs_to :site, Exblog.Domain.Site
    has_many :images, Image

    timestamps()
  end

  @doc false
  def changeset(post, attrs) do
    post
    |> cast(attrs, __schema__(:fields))
    |> validate_required([:title, :body])
    |> add_slug_to_changeset()
  end

  def title_slug(title) do
    String.downcase(title) |> String.replace(" ", "_")
  end

  defp add_slug_to_changeset(changeset = %{valid?: false}), do: changeset

  defp add_slug_to_changeset(changeset = %{changes: %{title: title}}) when title != nil do
    put_change(changeset, :slug, title_slug(title))
  end

  defp add_slug_to_changeset(changeset), do: changeset
end
