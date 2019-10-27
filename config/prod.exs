# Build-time application configuration, which is executed when the release is assembled
import Config

config :identicon_generator, IdenticonGenerator.Router,
  port: String.to_integer(System.get_env("PORT") || "4444"),
  redirect_url: System.get_env("REDIRECT_URL")
