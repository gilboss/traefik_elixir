defmodule Traefik.Handler do
  def handle(request) do
    request
    |> parse()
    |> route()
    |> format_response()
  end
end

def parse(request) do
  %{method: "GET", path: "/hello", response: ""}
end

def route(conn) do
  %{method: "GET", path: "/hello", response: "Hello world"}
end

def format_response(conn) do
  """
  HTTP/1.1 200 OK
  Host: some.com
  User-Abent: telnet
  Accept: */*

  """
end

request = """
GET / HTTP/1.1
Accept: */*
Connection: keep-alive
User-Agent: telnet

"""

IO.puts(request)
