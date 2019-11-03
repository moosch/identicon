defmodule IdenticonGenerator.Router do
  use Plug.Router
  use Plug.Debugger

  require Logger

  plug(Plug.Logger, log: :debug)
  plug(:match)
  plug(:dispatch)

  get "/healthcheck/ping" do
    conn
    |> put_resp_content_type("application/json")
    |> send_resp(200, Poison.encode!("pong!"))
  end

  get "/" do
    conn
    |> put_resp_content_type("application/json")
    |> send_resp(200, Poison.encode!(response_message()))
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

  defp response_message do
    %{
      response_type: "in_channel",
      text: "Append /your_name to the url to generate an Identicon"
    }
  end

end
