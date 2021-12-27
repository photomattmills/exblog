defmodule Exblog.Repo.Migrations.AddSlugsArrayToPosts do
  use Ecto.Migration

  def up do
    alter table("posts") do
      add :slugs, {:array, :string}
    end

    create index("posts", [:slugs], using: "GIN")
  end

  def down do
  end
end
