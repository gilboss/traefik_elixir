defmodule HandlerTest do
  use ExUnit.Case

  test "GET /world" do
    request1 = """
    GET /world HTTP/1.1
    Accept: */*
    Connection: keep-alive
    User-Agent: telnet

    """
  end
end
