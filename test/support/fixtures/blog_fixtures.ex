defmodule Exblog.BlogFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Exblog.Blog` context.
  """

  @doc """
  Generate a post.
  """
  def post_fixture(attrs \\ %{}) do
    {:ok, post} =
      attrs
      |> Enum.into(%{
        body: "some body",
        buy_link: "some buy_link",
        description: "some description",
        is_retail: true,
        og_image: "some og_image",
        page_only: true,
        published_at: ~U[2025-05-27 08:27:00Z],
        slug: "some slug",
        slugs: ["option1", "option2"],
        title: "some title"
      })
      |> Exblog.Blog.create_post()

    post
  end
end
