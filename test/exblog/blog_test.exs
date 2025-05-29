defmodule Exblog.BlogTest do
  use Exblog.DataCase

  alias Exblog.Blog

  describe "posts" do
    alias Exblog.Blog.Post

    import Exblog.BlogFixtures

    @invalid_attrs %{description: nil, title: nil, body: nil, buy_link: nil, og_image: nil, published_at: nil, slug: nil, slugs: nil, page_only: nil, is_retail: nil}

    test "list_posts/0 returns all posts" do
      post = post_fixture()
      assert Blog.list_posts() == [post]
    end

    test "get_post!/1 returns the post with given id" do
      post = post_fixture()
      assert Blog.get_post!(post.id) == post
    end

    test "create_post/1 with valid data creates a post" do
      valid_attrs = %{description: "some description", title: "some title", body: "some body", buy_link: "some buy_link", og_image: "some og_image", published_at: ~U[2025-05-27 08:27:00Z], slug: "some slug", slugs: ["option1", "option2"], page_only: true, is_retail: true}

      assert {:ok, %Post{} = post} = Blog.create_post(valid_attrs)
      assert post.description == "some description"
      assert post.title == "some title"
      assert post.body == "some body"
      assert post.buy_link == "some buy_link"
      assert post.og_image == "some og_image"
      assert post.published_at == ~U[2025-05-27 08:27:00Z]
      assert post.slug == "some slug"
      assert post.slugs == ["option1", "option2"]
      assert post.page_only == true
      assert post.is_retail == true
    end

    test "create_post/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Blog.create_post(@invalid_attrs)
    end

    test "update_post/2 with valid data updates the post" do
      post = post_fixture()
      update_attrs = %{description: "some updated description", title: "some updated title", body: "some updated body", buy_link: "some updated buy_link", og_image: "some updated og_image", published_at: ~U[2025-05-28 08:27:00Z], slug: "some updated slug", slugs: ["option1"], page_only: false, is_retail: false}

      assert {:ok, %Post{} = post} = Blog.update_post(post, update_attrs)
      assert post.description == "some updated description"
      assert post.title == "some updated title"
      assert post.body == "some updated body"
      assert post.buy_link == "some updated buy_link"
      assert post.og_image == "some updated og_image"
      assert post.published_at == ~U[2025-05-28 08:27:00Z]
      assert post.slug == "some updated slug"
      assert post.slugs == ["option1"]
      assert post.page_only == false
      assert post.is_retail == false
    end

    test "update_post/2 with invalid data returns error changeset" do
      post = post_fixture()
      assert {:error, %Ecto.Changeset{}} = Blog.update_post(post, @invalid_attrs)
      assert post == Blog.get_post!(post.id)
    end

    test "delete_post/1 deletes the post" do
      post = post_fixture()
      assert {:ok, %Post{}} = Blog.delete_post(post)
      assert_raise Ecto.NoResultsError, fn -> Blog.get_post!(post.id) end
    end

    test "change_post/1 returns a post changeset" do
      post = post_fixture()
      assert %Ecto.Changeset{} = Blog.change_post(post)
    end
  end
end
