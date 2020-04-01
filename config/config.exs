# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
import Config

config :mind_the_gapp,
  ecto_repos: [MindTheGapp.Repo]

# Configures the endpoint
config :mind_the_gapp, MindTheGappWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "obCyqU/uHP9P3gLtKqRtnH0OttHGDVo+gVVz+yb9Oh7eKL+YOfpnhoSwUmK1nZbm",
  render_errors: [view: MindTheGappWeb.ErrorView, accepts: ~w(html json)],
  pubsub: [name: MindTheGapp.PubSub, adapter: Phoenix.PubSub.PG2],
  live_view: [signing_salt: "HpBqHbsb"]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

config :mind_the_gapp, MindTheGapp.Mta.Scheduler,
jobs: [
 {{:extended, "*/30"},      {IO, :inspect, ["Test"]}}
]
# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
