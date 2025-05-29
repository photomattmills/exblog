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
  def changeset(post, attrs) do
    post
    |> cast(attrs, [
      :body,
      :buy_link,
      :description,
      :og_image,
      :published_at,
      :slug,
      :slugs,
      :title,
      :page_only,
      :is_retail
    ])
    |> validate_required([
      :body,
      :buy_link,
      :description,
      :og_image,
      :published_at,
      :slug,
      :slugs,
      :title,
      :page_only,
      :is_retail
    ])
  end
end
