defmodule ExblogWeb.Router do
  use ExblogWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :logged_in do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
    plug :user_logged_in
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", ExblogWeb do
    pipe_through :browser


    get "/", PostController, :index
    get "/post/:post_slug", PostController, :show_by_slug
    get "/login", LoginController, :login
    post "/login", LoginController, :do_login
  end

  scope "/", ExblogWeb do
    pipe_through :logged_in

    resources "/posts", PostController, except: [:index]
    resources "/accounts", AccountController
  end

  # Other scopes may use custom stacks.
  # scope "/api", ExblogWeb do
  #   pipe_through :api
  # end

  def user_logged_in(conn, _opts) do
    case Plug.Conn.get_session(conn, :logged_in) do
      true -> conn
      _ -> redirect(conn, to: Routes.login_path(conn, :login))
    end
  end
end
