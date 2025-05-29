defmodule ExblogWeb.SiteController do
  use ExblogWeb, :controller

  alias Exblog.Domain
  alias Exblog.Domain.Site

  def index(conn, _params) do
    sites = Domain.list_sites()
    render(conn, :index, sites: sites)
  end

  def new(conn, _params) do
    changeset = Domain.change_site(%Site{})
    render(conn, :new, changeset: changeset)
  end

  def create(conn, %{"site" => site_params}) do
    case Domain.create_site(site_params) do
      {:ok, site} ->
        conn
        |> put_flash(:info, "Site created successfully.")
        |> redirect(to: ~p"/sites/#{site}")

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, :new, changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    site = Domain.get_site!(id)
    render(conn, :show, site: site)
  end

  def edit(conn, %{"id" => id}) do
    site = Domain.get_site!(id)
    changeset = Domain.change_site(site)
    render(conn, :edit, site: site, changeset: changeset)
  end

  def update(conn, %{"id" => id, "site" => site_params}) do
    site = Domain.get_site!(id)

    case Domain.update_site(site, site_params) do
      {:ok, site} ->
        conn
        |> put_flash(:info, "Site updated successfully.")
        |> redirect(to: ~p"/sites/#{site}")

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, :edit, site: site, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    site = Domain.get_site!(id)
    {:ok, _site} = Domain.delete_site(site)

    conn
    |> put_flash(:info, "Site deleted successfully.")
    |> redirect(to: ~p"/sites")
  end
end
