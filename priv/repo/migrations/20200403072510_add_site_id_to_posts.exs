defmodule Exblog.Repo.Migrations.AddSiteIdToPosts do
  use Ecto.Migration

  def change do
    alter table("posts") do
      add :site_id, :integer
    end
  end
end
