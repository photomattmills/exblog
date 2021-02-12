defmodule Exblog.Repo.Migrations.AddDescriptionToSite do
  use Ecto.Migration

  def change do
    alter table("sites") do
      add :description, :string
    end
  end
end
