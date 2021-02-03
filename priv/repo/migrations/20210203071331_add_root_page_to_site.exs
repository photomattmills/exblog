defmodule Exblog.Repo.Migrations.AddRootPageToSite do
  use Ecto.Migration

  def change do
    alter table("sites") do
      add :root_page, :string
    end
  end
end
