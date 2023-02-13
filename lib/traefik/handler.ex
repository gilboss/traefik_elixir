defmodule Traefik.Handler do
  def handle(request) do
    request
    |> parse()
    |> route()
    |> format_response()
  end
end

request = """
GET / HTTP/1.1
Accept: */*
Connection: keep-alive
User-Agent: HTTPie/3.2.1

"""

IO.puts(request)
