# Build-time application configuration, which is executed when the release is assembled
import Config

config :identicon_generator, IdenticonGenerator.Router,
  http: [:inet6, port: System.get_env("PORT") || 4000],
  url: [host: "178.128.22.104", port: 80],
  server: true

# Do not print debug messages in production
config :logger, level: :info
