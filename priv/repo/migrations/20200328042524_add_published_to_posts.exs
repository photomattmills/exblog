defmodule Exblog.Repo.Migrations.AddPublishedToPosts do
  use Ecto.Migration

  def change do
    alter table("posts") do
      add :published, :boolean, default: true
    end
  end
end
