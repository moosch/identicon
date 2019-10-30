# Build-time application configuration, which is executed when the release is assembled
import Config

config :identicon_generator, IdenticonGenerator.Router,
  url: [host: "localhost", port: 4000, scheme: "http"],
  port: 8080,
  redirect_url: "http://localhost:8080"

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

import_config "#{Mix.env()}.exs"
