defmodule ExblogWeb.SiteHTML do
  use ExblogWeb, :html

  embed_templates "site_html/*"

  @doc """
  Renders a site form.
  """
  attr :changeset, Ecto.Changeset, required: true
  attr :action, :string, required: true

  def site_form(assigns)
end
