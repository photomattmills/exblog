defmodule Exblog.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      ExblogWeb.Telemetry,
      Exblog.Repo,
      {DNSCluster, query: Application.get_env(:exblog, :dns_cluster_query) || :ignore},
      {Phoenix.PubSub, name: Exblog.PubSub},
      # Start the Finch HTTP client for sending emails
      {Finch, name: Exblog.Finch},
      # Start a worker by calling: Exblog.Worker.start_link(arg)
      # {Exblog.Worker, arg},
      # Start to serve requests, typically the last entry
      ExblogWeb.Endpoint
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Exblog.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    ExblogWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
