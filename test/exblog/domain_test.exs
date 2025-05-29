defmodule Exblog.DomainTest do
  use Exblog.DataCase

  alias Exblog.Domain

  describe "sites" do
    alias Exblog.Domain.Site

    import Exblog.DomainFixtures

    @invalid_attrs %{header: nil, description: nil, title: nil, css: nil, host_name: nil, footer: nil, twitter_handle: nil, root_page: nil, per_page: nil}

    test "list_sites/0 returns all sites" do
      site = site_fixture()
      assert Domain.list_sites() == [site]
    end

    test "get_site!/1 returns the site with given id" do
      site = site_fixture()
      assert Domain.get_site!(site.id) == site
    end

    test "create_site/1 with valid data creates a site" do
      valid_attrs = %{header: "some header", description: "some description", title: "some title", css: "some css", host_name: "some host_name", footer: "some footer", twitter_handle: "some twitter_handle", root_page: "some root_page", per_page: 42}

      assert {:ok, %Site{} = site} = Domain.create_site(valid_attrs)
      assert site.header == "some header"
      assert site.description == "some description"
      assert site.title == "some title"
      assert site.css == "some css"
      assert site.host_name == "some host_name"
      assert site.footer == "some footer"
      assert site.twitter_handle == "some twitter_handle"
      assert site.root_page == "some root_page"
      assert site.per_page == 42
    end

    test "create_site/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Domain.create_site(@invalid_attrs)
    end

    test "update_site/2 with valid data updates the site" do
      site = site_fixture()
      update_attrs = %{header: "some updated header", description: "some updated description", title: "some updated title", css: "some updated css", host_name: "some updated host_name", footer: "some updated footer", twitter_handle: "some updated twitter_handle", root_page: "some updated root_page", per_page: 43}

      assert {:ok, %Site{} = site} = Domain.update_site(site, update_attrs)
      assert site.header == "some updated header"
      assert site.description == "some updated description"
      assert site.title == "some updated title"
      assert site.css == "some updated css"
      assert site.host_name == "some updated host_name"
      assert site.footer == "some updated footer"
      assert site.twitter_handle == "some updated twitter_handle"
      assert site.root_page == "some updated root_page"
      assert site.per_page == 43
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
