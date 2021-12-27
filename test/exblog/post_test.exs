defmodule Exblog.PostTest do
  use Exblog.DataCase
  alias Exblog.Blog.Post
  alias Exblog.Repo

  describe "changeset" do
    test "it adds a slug to the record" do
      attrs = %{title: "this is a title", body: "this is a body"}
      changeset = Post.changeset(%Post{}, attrs)

      assert changeset.valid?
      assert changeset.changes.slugs == ["this_is_a_title"]
    end

    test "it doesn't change the slug once it's set" do
      attrs = %{title: "this is a title", body: "this is a body"}
      changeset = Post.changeset(%Post{}, attrs)
      {:ok, post} = Repo.insert(changeset)

      new_attrs = %{title: "this is a new title", body: "this is a body"}

      new_changeset = Post.changeset(post, new_attrs)

      assert new_changeset.changes.slugs == ["this_is_a_new_title", "this_is_a_title"]
    end
  end
end
