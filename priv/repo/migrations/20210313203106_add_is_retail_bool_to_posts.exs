defmodule Exblog.Repo.Migrations.AddIsRetailBoolToPosts do
  use Ecto.Migration

  def change do
    alter table("posts") do
      add :is_retail, :boolean, default: false
    end
  end
end
