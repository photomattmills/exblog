defmodule Exblog.Repo.Migrations.AddSiteAndAccountToPosts do
  use Ecto.Migration

  def change do
    alter table("posts") do
      add :site_id, :integer
      add :user_id, :integer
    end
  end
end
