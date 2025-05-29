defmodule Exblog.DomainFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Exblog.Domain` context.
  """

  @doc """
  Generate a site.
  """
  def site_fixture(attrs \\ %{}) do
    {:ok, site} =
      attrs
      |> Enum.into(%{
        css: "some css",
        description: "some description",
        footer: "some footer",
        header: "some header",
        host_name: "some host_name",
        per_page: 42,
        root_page: "some root_page",
        title: "some title",
        twitter_handle: "some twitter_handle"
      })
      |> Exblog.Domain.create_site()

    site
  end
end
