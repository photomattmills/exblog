defmodule Exblog.Repo.Migrations.AddPerPageToSite do
  use Ecto.Migration

  def change do
    alter table("sites") do
      add :per_page, :integer, default: 5
    end
  end
end
