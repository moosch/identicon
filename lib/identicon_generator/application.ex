defmodule IdenticonGenerator.Application do
  @moduledoc """
  An endpoint to generate an Identicon based on a string in the url
  e.g. identicon/my_face
  """

  use Application

  def start(_type, _args) do
    children = [
      IdenticonGenerator.Router
    ]

    opts = [strategy: :one_for_one, name: IdenticonGenerator.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
