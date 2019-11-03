defmodule IdenticonGenerator.Application do
  @moduledoc """
  An endpoint to generate an Identicon based on a string in the url
  e.g. identicon/my_face
  """

  use Application

  require Logger

  def start(_type, _args) do
    port = get_port()

    children = [
      Plug.Cowboy.child_spec(
        scheme: :http,
        plug: IdenticonGenerator.Router,
        options: [port: port]
      )
    ]

    Logger.info("Starting server at http://localhost:#{port}/")

    opts = [strategy: :one_for_one, name: IdenticonGenerator.Supervisor]
    Supervisor.start_link(children, opts)
  end

  defp get_port, do: Application.get_env(:identicon_generator, :port, 8080)
end
