defmodule Exblog.Repo.Migrations.ChangePublishedToPublishedAt do
  use Ecto.Migration

  def change do
    alter table("posts") do
      add :published_at, :utc_datetime
      remove :published
    end
  end
end
