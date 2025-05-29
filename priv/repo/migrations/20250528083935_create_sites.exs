defmodule Exblog.Repo.Migrations.CreateSites do
  use Ecto.Migration

  def change do
    create table(:sites) do
      add :css, :string
      add :host_name, :string
      add :header, :string
      add :footer, :string
      add :twitter_handle, :string
      add :description, :string
      add :title, :string
      add :root_page, :string
      add :per_page, :integer

      timestamps(type: :utc_datetime)
    end
  end
end
