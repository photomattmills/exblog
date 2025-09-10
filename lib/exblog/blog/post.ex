defmodule Exblog.Blog.Post do
  use Ecto.Schema
  import Ecto.Changeset

  schema "posts" do
    field :description, :string
    field :title, :string
    field :body, :string
    field :buy_link, :string
    field :og_image, :string
    field :published_at, :utc_datetime
    field :slug, :string
    field :slugs, {:array, :string}
    field :page_only, :boolean, default: false
    field :is_retail, :boolean, default: false

    belongs_to :site, Exblog.Domain.Site
    belongs_to :user, Exblog.Accounts.User

    has_many :images, Exblog.Blog.Image

    timestamps(type: :utc_datetime)
  end

  @doc false
  # def changeset(post, attrs) do
  #   post
  #   |> cast(attrs, [
  #     :body,
  #     :buy_link,
  #     :description,
  #     :og_image,
  #     :published_at,
  #     :slug,
  #     :slugs,
  #     :title,
  #     :page_only,
  #     :is_retail
  #   ])
  #   |> validate_required([
  #     :body,
  #     :slug,
  #     :title
  #   ])
  # end

  def changeset(post, attrs) do
    post
    |> cast(attrs, __schema__(:fields))
    |> validate_required([:title])
    |> add_slug_to_changeset()
  end

  def title_slug(title) do
    String.downcase(title) |> String.replace(" ", "_")
  end

  defp add_slug_to_changeset(changeset = %{valid?: false}), do: changeset

  defp add_slug_to_changeset(changeset = %{changes: %{title: title}, data: %{slugs: slugs}})
       when title != nil and slugs != nil do
    put_change(changeset, :slugs, [title_slug(title) | slugs])
  end

  defp add_slug_to_changeset(changeset = %{changes: %{title: title}, data: %{slugs: slugs}})
       when title != nil and slugs == nil do
    put_change(changeset, :slugs, [title_slug(title)])
  end

  defp add_slug_to_changeset(changeset), do: changeset
end
