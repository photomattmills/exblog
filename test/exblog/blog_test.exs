defmodule Exblog.BlogTest do
  use Exblog.DataCase

  alias Exblog.Blog

  describe "posts" do
    alias Exblog.Blog.Post

    @valid_attrs %{
      body: "some body",
      description: "some description",
      og_image: "some og_image",
      is_retail: false,
      page_only: false,
      title: "some title"
    }
    @update_attrs %{
      body: "some updated body",
      description: "some updated description",
      og_image: "some updated og_image",
      title: "some updated title"
    }
    @invalid_attrs %{body: nil, description: nil, og_image: nil, title: nil}

    def post_fixture(attrs \\ %{}) do
      {:ok, post} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Blog.create_post()

      post |> Repo.preload(:images)
    end

    test "get_post!/1 returns the post with given id" do
      post = post_fixture()
      assert Blog.get_post!(post.id) == post
    end

    test "create_post/1 with valid data creates a post" do
      assert {:ok, %Post{} = post} = Blog.create_post(@valid_attrs)
      assert post.body == "some body"
      assert post.description == "some description"
      assert post.og_image == "some og_image"
      assert post.title == "some title"
    end

    test "create_post/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Blog.create_post(@invalid_attrs)
    end

    test "update_post/2 with valid data updates the post" do
      post = post_fixture()
      assert {:ok, %Post{} = post} = Blog.update_post(post, @update_attrs)
      assert post.body == "some updated body"
      assert post.description == "some updated description"
      assert post.og_image == "some updated og_image"
      assert post.title == "some updated title"
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
