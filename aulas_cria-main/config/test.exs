import Config

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :aulas_cria, AulasCriaWeb.Endpoint,
  http: [ip: {127, 0, 0, 1}, port: 4002],
  secret_key_base: "2vcLCC52qq4zmbupRcpbmSfXasSv3RO0sR8+fVGpyLOhylguGCfmNBwA1R+1Vpyc",
  server: false

# In test we don't send emails.
config :aulas_cria, AulasCria.Mailer, adapter: Swoosh.Adapters.Test

# Print only warnings and errors during test
config :logger, level: :warn

# Initialize plugs at runtime for faster test compilation
config :phoenix, :plug_init_mode, :runtime
