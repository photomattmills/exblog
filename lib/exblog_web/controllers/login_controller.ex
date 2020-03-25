defmodule ExblogWeb.LoginController do
  use ExblogWeb, :controller
  alias Exblog.Blog.Account
  alias Exblog.Repo


  def login(conn, _params) do
    render(conn, "login.html", changeset: %{})
  end

  def do_login(conn, %{"login" => params}) do
    with account <- Repo.get_by(Account, username: params["username"]),
        {:ok, _account}  <- Bcrypt.check_pass(account, params["password"]) do
      conn
      |> Plug.Conn.put_session(:logged_in, true)
      |> redirect(to: Routes.post_path(conn, :index))
    else
      _ -> redirect(conn, to: Routes.login_path(conn, :login))
    end
  end

  def logout(conn, _params) do
    conn
    |> Plug.Conn.put_session(:logged_in, false)
    |> redirect(to: Routes.post_path(conn, :index))
  end
end
