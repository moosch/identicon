use Mix.Config

config :identicon_generator, IdenticonGenerator.Router,
  port: String.to_integer(System.get_env("PORT") || "4444")

config :identicon_generator, redirect_url: System.get_env("REDIRECT_URL")
