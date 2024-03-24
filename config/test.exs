import Config

# Configure your database
#
# The MIX_TEST_PARTITION environment variable can be used
# to provide built-in test partitioning in CI environment.
# Run `mix help test` for more information.
config :instatus_api_consumer, InstatusAPIConsumer.Repo,
  username: System.get_env("DATABASE_USERNAME"),
  password: System.get_env("DATABASE_PASSWORD"),
  hostname: System.get_env("DATABASE_HOST"),
  database: "#{System.get_env("DATABASE_NAME")}#{System.get_env("MIX_TEST_PARTITION")}",
  pool: Ecto.Adapters.SQL.Sandbox,
  pool_size: 10

# Configures Oban for tests
config :instatus_api_consumer, Oban, testing: :manual

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :instatus_api_consumer, InstatusAPIConsumerWeb.Endpoint,
  http: [ip: {127, 0, 0, 1}, port: 4002],
  secret_key_base: "Y9NIdNbiTmTUxVdjVvPt7U9VP8CIBt7HRsAaUYYTfRgVcqRIzW/aZ4yZPTRBX6kw",
  server: false

# Print only warnings and errors during test
config :logger, level: :warning

# Initialize plugs at runtime for faster test compilation
config :phoenix, :plug_init_mode, :runtime
