defmodule Exblog.DomainTest do
  use Exblog.DataCase

  alias Exblog.Domain

  describe "sites" do
    alias Exblog.Domain.Site

    @valid_attrs %{css: "some css", host_name: "some host_name", per_page: 5}
    @update_attrs %{css: "some updated css", host_name: "some updated host_name"}
    @invalid_attrs %{css: nil, host_name: nil}

    def site_fixture(attrs \\ %{}) do
      {:ok, site} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Domain.create_site()

      site
    end

    test "list_sites/0 returns all sites" do
      site = site_fixture()
      assert Domain.list_sites() == [site]
    end

    test "get_site!/1 returns the site with given id" do
      site = site_fixture()
      assert Domain.get_site!(site.id) == site
    end

    test "create_site/1 with valid data creates a site" do
      assert {:ok, %Site{} = site} = Domain.create_site(@valid_attrs)
      assert site.css == "some css"
      assert site.host_name == "some host_name"
    end

    test "create_site/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Domain.create_site(@invalid_attrs)
    end

    test "update_site/2 with valid data updates the site" do
      site = site_fixture()
      assert {:ok, %Site{} = site} = Domain.update_site(site, @update_attrs)
      assert site.css == "some updated css"
      assert site.host_name == "some updated host_name"
    end

    test "update_site/2 with invalid data returns error changeset" do
      site = site_fixture()
      assert {:error, %Ecto.Changeset{}} = Domain.update_site(site, @invalid_attrs)
      assert site == Domain.get_site!(site.id)
    end

    test "delete_site/1 deletes the site" do
      site = site_fixture()
      assert {:ok, %Site{}} = Domain.delete_site(site)
      assert_raise Ecto.NoResultsError, fn -> Domain.get_site!(site.id) end
    end

    test "change_site/1 returns a site changeset" do
      site = site_fixture()
      assert %Ecto.Changeset{} = Domain.change_site(site)
    end
  end
end
