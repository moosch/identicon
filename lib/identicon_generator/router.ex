defmodule IdenticonGenerator.Router do
  use Plug.Router

  plug(:match)
  plug(:dispatch)

  get "/" do
    conn
    |> put_resp_content_type("application/json")
    |> send_resp(200, Poison.encode!(message()))
  end

  get "/:name" do
    %{ "name" => name } = conn.params
    conn
    |> put_resp_content_type("image/png")
    |> send_resp(200, IdenticonGenerator.Identicon.main(name))
  end

  match _ do
    send_resp(conn, 404, "oops")
  end

  defp message do
    %{
      response_type: "in_channel",
      text: "Append /your_name to the url to generate an Identicon"
    }
  end

  def child_spec(opts) do
    %{
      id: __MODULE__,
      start: {__MODULE__, :start_link, [opts]}
    }
  end

  def start_link(_opts) do
    Plug.Adapters.Cowboy.http(__MODULE__, [])
  end
end
