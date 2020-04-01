defmodule ExblogWeb.LoginControllerTest do
  use ExblogWeb.ConnCase
  alias Exblog.Blog.Accounts

  @valid_attrs %{username: "matt", password_hash: "real_password"}

  def fixture(:account) do
    {:ok, account} = Accounts.create_account(@valid_attrs)
    account
  end

  describe "login_form" do
    test "renders form", %{conn: conn} do
      conn = get(conn, Routes.login_path(conn, :login))
      assert html_response(conn, 200) =~ "login"
    end
  end

  describe "do_login" do
    setup %{conn: conn} do
      %{account: fixture(:account), conn: conn}
    end

    test "posting the correct creds returns 302", %{conn: conn} do
      conn =
        post(
          conn,
          Routes.login_path(conn, :login, %{
            login: %{username: @valid_attrs.username, password: @valid_attrs.password_hash}
          })
        )

      assert html_response(conn, 302)
    end
  end
end
