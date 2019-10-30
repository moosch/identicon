# Build-time application configuration, which is executed when the release is assembled
import Config

config :identicon_generator, IdenticonGenerator.Router,
  http: [port: 4000],

# Do not include metadata nor timestamps in development logs
config :logger, :console, format: "[$level] $message\n"
