defmodule Traefik.Parser do
  alias Traefik.Conn

  def parse(request) do
    [main, params_string] = String.split(request, "\n\n")

    [request_line | _headers] = String.split(main, "\n")

    params = URI.decode(params_string)

    [method, path, _protocol] =
      request_line
      |> String.split("\n")
      |> List.first()
      |> String.split(" ")

    %Conn{method: method, path: path, params: params}
  end
end
