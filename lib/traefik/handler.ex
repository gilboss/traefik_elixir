defmodule Traefik.Handler do
  def handler(request) do
    request
    |> parse()
    |> log()
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

  def log(conn), do: IO.inspect(conn, label: "log")

  def route(conn) do
    route(conn, conn.method, conn.path)
  end

  def route(conn, "GET", "/hello") do
    %{conn | response: "Hello world"}
  end

  def route(conn, "GET", "/world") do
    %{conn | response: "Hola Making devs"}
  end

  def format_response(conn) do
    """
    HTTP/1.1 200 OK
    Host: some.com
    User-Abent: telnet
    Content-Lenght: #{String.length(conn.response)}
    Accept: */*

    #{conn.response}
    """
  end
end

request = """
GET /world HTTP/1.1
Accept: */*
Connection: keep-alive
User-Agent: telnet

"""

IO.puts(Traefik.Handler.handler(request))
