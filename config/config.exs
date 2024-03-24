# This file is responsible for configuring your application
# and its dependencies with the aid of the Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
import Config

config :instatus_api_consumer,
  namespace: InstatusAPIConsumer,
  ecto_repos: [InstatusAPIConsumer.Repo],
  generators: [timestamp_type: :utc_datetime, binary_id: true]

# Configures the endpoint
config :instatus_api_consumer, InstatusAPIConsumerWeb.Endpoint,
  url: [host: "localhost"],
  adapter: Phoenix.Endpoint.Cowboy2Adapter,
  render_errors: [
    formats: [json: InstatusAPIConsumerWeb.ErrorJSON],
    layout: false
  ],
  pubsub_server: InstatusAPIConsumer.PubSub,
  live_view: [signing_salt: "9Xe2Rilr"]

# Configures Oban
config :instatus_api_consumer, Oban,
  repo: InstatusAPIConsumer.Repo,
  plugins: [
    {Oban.Plugins.Pruner, max_age: 60 * 60 * 24 * 7},
    {Oban.Plugins.Lifeline, rescue_after: :timer.minutes(30)}
  ],
  queues: [default: 10]

# Configure esbuild (the version is required)
config :esbuild,
  version: "0.17.11",
  default: [
    args:
      ~w(js/app.js --bundle --target=es2017 --outdir=../priv/static/assets --external:/fonts/* --external:/images/*),
    cd: Path.expand("../assets", __DIR__),
    env: %{"NODE_PATH" => Path.expand("../deps", __DIR__)}
  ]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{config_env()}.exs"
