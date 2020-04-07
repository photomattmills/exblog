# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :exblog,
  ecto_repos: [Exblog.Repo],
  s3_bucket: "mattdotpicturesimages-dev",
  s3_base_url: "https://mattdotpicturesimages-dev.s3-us-west-2.amazonaws.com"

# Configures the endpoint
config :exblog, ExblogWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "HcCRYcz39xJYs+tpsqDYlWfRfohDFIcyPqCeYH8SuzZ8KdQ8JZIX9allytZtZMRV",
  render_errors: [view: ExblogWeb.ErrorView, accepts: ~w(html json)],
  pubsub: [name: Exblog.PubSub, adapter: Phoenix.PubSub.PG2],
  live_view: [signing_salt: "lGEPsLhy"]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
