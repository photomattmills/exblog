defmodule Exblog.Repo.Migrations.AddPageBoolToPosts do
  use Ecto.Migration

  def change do
    alter table("posts") do
      add :page_only, :boolean, default: false
    end
  end
end
