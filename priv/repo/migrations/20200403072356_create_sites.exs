defmodule Exblog.Repo.Migrations.CreateSites do
  use Ecto.Migration

  def change do
    create table(:sites) do
      add :host_name, :string
      add :css, :text
      add :header, :text
      add :footer, :text
      add :twitter_handle, :text
      add :title, :text

      timestamps()
    end
  end
end
