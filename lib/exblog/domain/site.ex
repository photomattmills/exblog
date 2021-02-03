defmodule Exblog.Domain.Site do
  use Ecto.Schema
  import Ecto.Changeset

  schema "sites" do
    field :css, :string
    field :host_name, :string
    field :header, :string
    field :footer, :string
    field :twitter_handle, :string
    field :title, :string
    field :root_page, :string
    field :per_page, :integer

    timestamps()
  end

  @doc false
  def changeset(site, attrs) do
    site
    |> cast(attrs, [
      :css,
      :host_name,
      :header,
      :footer,
      :twitter_handle,
      :title,
      :root_page,
      :per_page
    ])
    |> validate_required([:host_name])
  end
end
