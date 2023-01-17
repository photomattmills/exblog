defmodule ExblogWeb.Router do
  use ExblogWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_live_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
    plug :put_root_layout, {ExblogWeb.LayoutView, :app}
    plug ExblogWeb.SitePlug
  end

  pipeline :logged_in do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
    plug :user_logged_in
    plug ExblogWeb.SitePlug
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", ExblogWeb do
    pipe_through :logged_in

    resources "/posts", PostController, except: [:index, :delete]
    get "/posts/:id/delete", PostController, :delete
    get "/admin/posts", PostController, :admin_index
    resources "/accounts", AccountController
    resources "/images", ImageController, only: [:create, :delete]
    get "/images/:id/delete", ImageController, :delete

    resources "/sites", SiteController
  end

  scope "/", ExblogWeb do
    pipe_through :browser

    get "/", PostController, :index
    get "/page/:page", PostController, :index
    get "/post/:post_slug", PostController, :show_by_slug
    get "/login", LoginController, :login
    get "/logout", LoginController, :logout
    post "/login", LoginController, :do_login
    get "/rss", PostController, :rss
    get "/:post_slug", PostController, :show_by_slug, as: "root_post"
  end

  scope "/live", ExblogWeb do
    live "/posts", PostLive.Index, :index
    live "/posts/new", PostLive.Index, :new
    live "/posts/:id/edit", PostLive.Index, :edit

    live "/posts/:id", PostLive.Show, :show
    live "/posts/:id/show/edit", PostLive.Show, :edit
  end

  # Other scopes may use custom stacks.
  # scope "/api", ExblogWeb do
  #   pipe_through :api
  # end

  def user_logged_in(conn, _opts) do
    case Plug.Conn.get_session(conn, :logged_in) do
      true ->
        conn

      _ ->
        redirect(conn, to: ExblogWeb.Router.Helpers.login_path(conn, :login))
    end
  end
end
