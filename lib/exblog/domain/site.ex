defmodule Exblog.Domain.Site do
  use Ecto.Schema
  import Ecto.Changeset

  schema "sites" do
    field :header, :string
    field :description, :string
    field :title, :string
    field :css, :string
    field :host_name, :string
    field :footer, :string
    field :twitter_handle, :string
    field :root_page, :string
    field :per_page, :integer

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(site, attrs) do
    site
    |> cast(attrs, [:css, :host_name, :header, :footer, :twitter_handle, :description, :title, :root_page, :per_page])
    |> validate_required([:css, :host_name, :header, :footer, :twitter_handle, :description, :title, :root_page, :per_page])
  end
end
