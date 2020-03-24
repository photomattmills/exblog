defmodule Exblog.PostTest do
  use Exblog.DataCase
  alias Exblog.Blog.Post


  describe "changeset" do
    test "it adds a slug to the record" do
      attrs = %{title: "this is a title", body: "this is a body"}
      changeset = Post.changeset(%Post{}, attrs)

      assert changeset.valid?
      assert changeset.changes.slug == "this_is_a_title"
    end
  end
end
