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
  pubsub_server: Exblog.PubSub,
  live_view: [signing_salt: "lGEPsLhy"]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

config :logger, backends: [{LoggerFileBackend, :request_log}],
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Keep a seperate log file for each env.
# logs are stored in the root directory of the application
# inside the logs folder.
# Note: Remember to specify the format along with the metadata required.
# Configurable per LoggerFileBackend.
config :logger, :request_log,
  path: "logs/request.#{Mix.env}.log",
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
