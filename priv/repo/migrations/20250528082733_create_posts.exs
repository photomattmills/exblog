defmodule Exblog.Repo.Migrations.CreatePosts do
  use Ecto.Migration

  def change do
    create table(:posts) do
      add :body, :string
      add :buy_link, :string
      add :description, :string
      add :og_image, :string
      add :published_at, :utc_datetime
      add :slug, :string
      add :slugs, {:array, :string}
      add :title, :string
      add :page_only, :boolean, default: false, null: false
      add :is_retail, :boolean, default: false, null: false

      timestamps(type: :utc_datetime)
    end
  end
end
