defmodule Traefik.Handler do
  def handler(request) do
    request
    |> parse()
    |> route()
    |> format_response()
  end

  def parse(request) do
    [method, path, _protocol] =
      request
      |> String.split("\n")
      |> List.first()
      |> String.split(" ")

    %{method: method, path: path, response: ""}
  end

  def route(_conn) do
    %{method: "GET", path: "/hello", response: "Hello world"}
  end

  def format_response(_conn) do
    """
    HTTP/1.1 200 OK
    Host: some.com
    User-Abent: telnet
    Accept: */*

    """
  end
end

request = """
GET / HTTP/1.1
Accept: */*
Connection: keep-alive
User-Agent: telnet

"""

IO.puts(Traefik.Handler.handler(request))