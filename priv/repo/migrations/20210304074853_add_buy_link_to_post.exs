defmodule Exblog.Repo.Migrations.AddBuyLinkToPost do
  use Ecto.Migration

  def change do
    alter table("posts") do
      add :buy_link, :string
    end
  end
end
