ExUnit.start()
Ecto.Adapters.SQL.Sandbox.mode(Exblog.Repo, :manual)

defmodule FakeUploader do
  def upload(_file, _key) do
    :ok
  end

  def delete(_key) do
    :ok
  end
end
