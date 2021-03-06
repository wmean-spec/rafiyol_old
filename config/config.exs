# This file is responsible for configuring your umbrella
# and **all applications** and their dependencies with the
# help of Mix.Config.
#
# Note that all applications in your umbrella share the
# same configuration and dependencies, which is why they
# all use the same configuration file. If you want different
# configurations or dependencies per app, it is best to
# move said applications out of the umbrella.
use Mix.Config

# Configure Mix tasks and generators
config :rafiyol,
  ecto_repos: [Rafiyol.Repo]

config :rafiyol_web,
  ecto_repos: [Rafiyol.Repo],
  generators: [context_app: :rafiyol]

# Configures the endpoint
config :rafiyol_web, RafiyolWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "2BZK1jRCh+a+PcM6ZzqyfpaGUZ8LbWdF/Ne9uHGEB/dJJwuoRVfkNC/i00hpuYeL",
  render_errors: [view: RafiyolWeb.ErrorView, accepts: ~w(html json), layout: false],
  pubsub_server: Rafiyol.PubSub,
  live_view: [signing_salt: "Ac1vOksO"]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
