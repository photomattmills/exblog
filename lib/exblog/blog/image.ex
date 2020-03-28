defmodule Exblog.Blog.Image do
  use Ecto.Schema
  import Ecto.Changeset
  alias Exblog.Blog.Post

  schema "images" do
    field :url, :string
    field :caption, :string
    belongs_to :post, Post

    timestamps()
  end

  def changeset(post, attrs) do
    post
    |> cast(attrs, [:url, :caption, :post_id])
  end
end
