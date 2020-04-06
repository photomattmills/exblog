defmodule Exblog.Blog do
  @moduledoc """
  The Blog context.
  """

  import Ecto.Query, warn: false
  alias Exblog.Repo

  alias Exblog.Blog.Post

  @doc """
  Returns the list of posts.

  ## Examples

      iex> list_posts()
      [%Post{}, ...]

  """
  def list_posts(page, site_id) do
    %{
      posts:
        posts_query(site_id) |> limit(^post_limit()) |> offset(^post_offset(page)) |> Repo.all(),
      next_page: next_page(page, site_id),
      previous_page: page - 1
    }
  end

  def list_all_posts(site_id) do
    posts_query(site_id) |> Repo.all()
  end

  def next_page(page, site_id) do
    if Repo.aggregate(posts_query(site_id), :count, :id) > page * post_limit() do
      page + 1
    else
      1
    end
  end

  defp posts_query(site_id) do
    from(p in Post,
      where: not is_nil(p.published_at),
      where: [site_id: ^site_id],
      order_by: [desc: :published_at]
    )
  end

  defp post_limit do
    Application.get_env(:exblog, :posts_per_page, 5)
  end

  defp post_offset(page) do
    (page - 1) * post_limit()
  end

  def list_posts() do
    Repo.all(Post)
  end

  @doc """
  Gets a single post.

  Raises `Ecto.NoResultsError` if the Post does not exist.

  ## Examples

      iex> get_post!(123)
      %Post{}

      iex> get_post!(456)
      ** (Ecto.NoResultsError)

  """
  def get_post!(id), do: Repo.get!(Post, id) |> Repo.preload(:images)

  def get_post_by_slug!(slug), do: Repo.get_by(Post, slug: slug)

  @doc """
  Creates a post.

  ## Examples

      iex> create_post(%{field: value})
      {:ok, %Post{}}

      iex> create_post(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_post(attrs \\ %{}) do
    %Post{}
    |> Post.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a post.

  ## Examples

      iex> update_post(post, %{field: new_value})
      {:ok, %Post{}}

      iex> update_post(post, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_post(%Post{} = post, attrs) do
    attrs = add_published_at(post, attrs)

    post
    |> Post.changeset(attrs)
    |> Repo.update()
  end

  defp add_published_at(_post = %{published_at: nil}, attrs) do
    Map.merge(attrs, %{"published_at" => DateTime.utc_now()})
  end

  defp add_published_at(_,attrs), do: attrs

  @doc """
  Deletes a post.

  ## Examples

      iex> delete_post(post)
      {:ok, %Post{}}

      iex> delete_post(post)
      {:error, %Ecto.Changeset{}}

  """
  def delete_post(%Post{} = post) do
    Repo.delete(post)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking post changes.

  ## Examples

      iex> change_post(post)
      %Ecto.Changeset{source: %Post{}}

  """
  def change_post(%Post{} = post) do
    Post.changeset(post, %{})
  end
end
