use Mix.Config

config :identicon_generator, IdenticonGenerator.Router, port: 8080
config :identicon_generator, redirect_url: "http://localhost:8080"

import_config "#{Mix.env()}.exs"
