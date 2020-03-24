defmodule Exblog.Blog.Account do
  use Ecto.Schema
  import Ecto.Changeset

  schema "accounts" do
    field :password_hash, :string
    field :username, :string

    timestamps()
  end

  @doc false
  def changeset(account, attrs) do
    account
    |> cast(attrs, [:username, :password_hash])
    |> validate_required([:username, :password_hash])
    |> update_change(:password_hash, &Bcrypt.hash_pwd_salt/1)
  end
end
