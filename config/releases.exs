import Config

port = System.fetch_env!("PORT")

config :identicon_generator, IdenticonGenerator.Router,
  load_from_system_env: true,
  port: port,
  check_origin: false,
  server: true,
  root: "."

config :logger, level: :info
