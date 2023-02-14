defmodule Traefik.Handler do
  @files_path Path.expand("../../pages", __DIR__)

  def handler(request) do
    request
    |> parse()
    |> log()
    |> route()
    |> track()
    |> format_response()
  end

  def parse(request) do
    [method, path, _protocol] =
      request
      |> String.split("\n")
      |> List.first()
      |> String.split(" ")

    %{method: method, path: path, response: "", status: ""}
  end

  def log(conn), do: IO.inspect(conn, label: "log")

  def route(conn) do
    route(conn, conn.method, conn.path)
  end

  def route(conn, "GET", "/hello") do
    %{conn | status: 200, response: "Hello world"}
  end

  def route(conn, "GET", "/world") do
    %{conn | status: 200, response: "Hola Making devs"}
  end

  def route(conn, "GET", "/all") do
    %{conn | status: 200, response: "All developers greetings"}
  end

  def route(conn, "GET", "/about") do
    @files_path
    |> Path.join("about.html")
    |> File.read()
    |> handle_file(conn)
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

  def handle_file({:ok, content}, conn), do: %{conn | status: 200, response: content}

  def handle_file({:error, reason}, conn),
    do: %{conn | status: 404, response: "File not fount #{inspect(reason)}!!"}

  def route(conn, _method, path) do
    %{conn | status: 404, response: "No #{path} found!!"}
  end

  def track(%{status: 404, path: path} = conn) do
    IO.inspect("Warn path #{path} not found")
    conn
  end

  def track(conn), do: conn

  def format_response(conn) do
    """
    HTTP/1.1 #{conn.status} #{status_reason(conn.status)}
    Host: some.com
    User-Abent: telnet
    Content-Lenght: #{String.length(conn.response)}
    Accept: */*

    #{conn.response}
    """
  end

  defp status_reason(code) do
    %{
      200 => "OK",
      201 => "created",
      401 => "unauthorized",
      403 => "forbidden",
      404 => "Not found",
      500 => "Internal server error"
    }
    |> Map.get(code)
  end
end

request = """
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

IO.puts(Traefik.Handler.handler(request))
IO.puts(Traefik.Handler.handler(request2))
