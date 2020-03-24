defmodule Exblog.Repo.Migrations.CreatePosts do
  use Ecto.Migration

  def change do
    create table(:posts) do
      add :title, :string
      add :og_image, :string
      add :description, :string
      add :body, :string

      timestamps()
    end

  end
end
