# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :third_rail,
  ecto_repos: [ThirdRail.Repo]

# Configures the endpoint
config :third_rail, ThirdRailWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "9T0fKjXszLOOPRl04U2Wefoezv+sj6lwNbyCV9XS/wnI6WmVwOT83qu12CBKYe5u",
  render_errors: [view: ThirdRailWeb.ErrorView, accepts: ~w(html json), layout: false],
  pubsub_server: ThirdRail.PubSub,
  live_view: [signing_salt: "CO9Xuj7y"]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
