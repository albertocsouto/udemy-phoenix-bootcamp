use Mix.Config

# Configure your database
config :discuss, Discuss.Repo,
  username: "travis",
  password: "travis",
  database: "discuss_dev",
  hostname: "localhost",
  port: 5433,
  pool: Ecto.Adapters.SQL.Sandbox

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :test_api, TestApiWeb.Endpoint,
  http: [port: 4002],
  server: false

# Print only warnings and errors during test
config :logger, level: :warn
