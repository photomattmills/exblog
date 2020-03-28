defmodule Exblog.Repo.Migrations.AddImagesTable do
  use Ecto.Migration

  def change do
    create table(:images) do
      add :url, :string
      add :caption, :string
      add :post_id, :integer
      
      timestamps()
    end
  end
end
