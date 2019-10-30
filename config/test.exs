# Build-time application configuration, which is executed when the release is assembled
import Config

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :identicon_generator, IdenticonGenerator.Router,
  http: [port: 4002],
  server: false

# Print only warnings and errors during test
config :logger, level: :warn
