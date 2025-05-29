defmodule Exblog.Repo.Migrations.FixSites do
  use Ecto.Migration

  def change do
    alter table("sites") do
      modify :css, :text
      modify :header, :text
      modify :footer, :text
      modify :twitter_handle, :text
      modify :title, :text
    end
  end
end
