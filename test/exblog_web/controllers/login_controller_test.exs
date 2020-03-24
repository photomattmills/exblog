defmodule ExblogWeb.LoginControllerTest do
  use ExblogWeb.ConnCase
  alias ExBlog.Blog

  def fixture(:account) do
    {:ok, account} = Blog.create_account()
    account
  end

  describe "login_form" do
    test "renders form", %{conn: conn} do
      conn = get(conn, Routes.login_path(conn, :login))
      assert html_response(conn, 200) =~ "login"
    end
  end

  describe "do_login" do
  end
end
