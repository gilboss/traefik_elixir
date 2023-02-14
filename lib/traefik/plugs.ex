defmodule Traefik.Plugs do
  def rewrite_path(%{path: "/redirectme"} = conn) do
    %{conn | path: "/all"}
  end

  def log(conn), do: IO.inspect(conn, label: "log")

  def track(%{status: 404, path: path} = conn) do
    IO.inspect("Warn path #{path} not found")
    conn
  end

  def track(conn), do: conn
end
