defmodule Exblog.Repo.Migrations.MigrateSlugToSlugs do
  use Ecto.Migration
  alias Exblog.Repo
  alias Exblog.Blog.Post

  def change do
    Repo.all(Post)
    |> Enum.map(fn post ->
      Post.changeset(post, %{slugs: [post.slug]})
      |> Repo.update()
    end)
  end
end
