defmodule Exblog.Repo.Migrations.CreateUsers do
  use Ecto.Migration

  def change do
    create table(:users) do
      add :password_hash, :string
      add :username, :string

      timestamps(type: :utc_datetime)
    end
  end
end
