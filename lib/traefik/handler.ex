defmodule Traefik.Handler do
  @files_path Path.expand("../../pages", __DIR__)

  import Traefik.Plugs, only: [log: 1, track: 1]
  import Traefik.Parser, only: [parse: 1]

  alias Traefik.Conn

  def handler(request) do
    request
    |> parse()
    |> log()
    |> route()
    |> track()
    |> format_response()
  end

  def route(%Conn{method: "GET", path: "/hello"} = conn) do
    %{conn | status: 200, response: "Hello world"}
  end

  def route(%Conn{method: "GET", path: "/world"} = conn) do
    %{conn | status: 200, response: "Hola Making devs"}
  end

  def route(%Conn{method: "GET", path: "/all"} = conn) do
    %{conn | status: 200, response: "All developers greetings"}
  end

  def route(%Conn{method: "POST", path: "/new", params: params} = conn) do
    %{conn | status: 201, response: "A new element created"}
  end

  def route(%Conn{method: "GET", path: "/about"} = conn) do
    @files_path
    |> Path.join("about.html")
    |> File.read()
    |> handle_file(conn)
  end

  def route(%Conn{} = conn, _method, path) do
    %{conn | status: 404, response: "No #{path} found!!"}
  end

  #  def route(conn, "GET", "/about") do
  #    Path.expand("../../pages", __DIR__)
  #    |> Path.join("about.html")
  #    |> File.read()
  #    |> case do
  #      {:ok, content} ->
  #        %{conn | status: 200, response: content}
  #
  #      {:error, reason} ->
  #        %{conn | status: 404, response: "File not fount #{inspect(reason)}!!"}
  #    end
  #  end

  def handle_file({:ok, content}, %Conn{} = conn), do: %{conn | status: 200, response: content}

  def handle_file({:error, reason}, %Conn{} = conn),
    do: %{conn | status: 404, response: "File not fount #{inspect(reason)}!!"}

  def format_response(conn) do
    """
    HTTP/1.1 #{Conn.status(conn)}}
    Host: some.com
    User-Abent: telnet
    Content-Lenght: #{String.length(conn.response)}
    Accept: */*

    #{conn.response}
    """
  end
end

request1 = """
GET /world HTTP/1.1
Accept: */*
Connection: keep-alive
User-Agent: telnet

"""

request2 = """
GET /about HTTP/1.1
Accept: */*
Connection: keep-alive
User-Agent: telnet

"""

request6 = """
POST /new HTTP/1.1
Accept: */*
Connection: keep-alive
Cpmtemt-Type: application/x-www-form-urlencoded
User-Agent: telnet

name=juan&company=md
"""

IO.puts(Traefik.Handler.handler(request1))
IO.puts(Traefik.Handler.handler(request2))
IO.puts(Traefik.Handler.handler(request6))
