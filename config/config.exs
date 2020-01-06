# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :nuzzelish,
  ecto_repos: [Nuzzelish.Repo]

# Configures the endpoint
config :nuzzelish, NuzzelishWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "FgGGYGWqf+tYEtCZBDWcRz2jaRTly+j9IW6a8lvxh9wqWEjmkIPQNIi7HwhFX73H",
  render_errors: [view: NuzzelishWeb.ErrorView, accepts: ~w(html json)],
  pubsub: [name: Nuzzelish.PubSub, adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Config Extwitter
config :extwitter, :oauth, [
   consumer_key: System.get_env("TW_CONSUMER_KEY"),
   consumer_secret: System.get_env("TW_CONSUMER_SECRET"),
   access_token: System.get_env("TW_ACCESS_TOKEN"),
   access_token_secret: System.get_env("TW_ACCESS_TOKEN_SECRET")
]

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
