defmodule TraefikTest do
  alias ElixirLS.LanguageServer.Tracer
  use ExUnit.Case
  doctest Traefik

  test "greets the world" do
    assert Traefik.hello() == :world
  end

  test "parse the headers from a request into map" do
    headers = ["Accept: */*", "Connection: keep-alive"]
    headers = Traefik.Parser.parse_headers(headers, %{})
    assert headers == %{"Accept" => "*/*", "Connection" => "keep-alive"}
  end

  test "parses the params from a request " do
    params_string = "a=1&b=2&c=3"
    params = Traefik.Parser.parse_params("application/x-www-form-urlencoded", params_string)
    assert params == %{"a" => "1", "b" => "2", "c" => "3"}
  end
end
