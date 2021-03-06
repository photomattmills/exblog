defmodule ExblogWeb.PostView do
  use ExblogWeb, :view

  def published(%{published_at: pa}) when pa != nil, do: true
  def published(_post), do: false

  def escape_xml(string) do
    string
    |> String.replace(">", "&gt;")
    |> String.replace("<", "&lt;")
    |> String.replace(~s|"|, "&quot;")
    |> String.replace("'", "&apos;")
    |> replace_ampersand
  end

  defp replace_ampersand(string) do
    Regex.replace(~r/&(?!(lt|gt|quot|apos|amp);)/, string, "&amp;")
  end
end
