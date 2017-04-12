use Mix.Config

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :rumbl, Rumbl.Endpoint,
  http: [port: 4001],
  server: false

# Print only warnings and errors during test
config :logger, level: :warn

# Эти настройки позволяют ускорить хеширование паролей в тестовой среде
config :comeonin, :bcrypt_log_rounds, 4
config :comeonin, :pbkdf2_rounds, 1

# Configure your database
config :rumbl, Rumbl.Repo,
  adapter: Ecto.Adapters.Postgres,
  username: "carefreeslacker",
  password: "123123",
  database: "rumbl_test",
  hostname: "localhost",
  pool_size: 5,
  pool: Ecto.Adapters.SQL.Sandbox

config :rumbl, :wolfram,
			 app_id: "1234",
			 http_client: InfoSys.Test.HTTPClient
