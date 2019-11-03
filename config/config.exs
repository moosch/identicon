# Build-time application configuration, which is executed when the release is assembled
import Config

config :identicon_generator, port: 4000

config :logger, level: :info

import_config "#{Mix.env()}.exs"
