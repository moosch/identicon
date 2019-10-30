import Config

config :identicon_generator, IdenticonGenerator.Router,
  url: [host: System.get_env("APP_HOST"), port: 4000, scheme: "http"],
  port: 4000
