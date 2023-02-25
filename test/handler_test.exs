defmodule HandlerTest do
  use ExUnit.Case

  alias Traefik.Handler

  test "GET /hello" do
    request = """
    GET /hello HTTP/1.1
    Accept: */*
    Connection: keep-alive
    User-Agent: telnet

    """

    response = Handler.handler(request)

    assert response == """
           HTTP/1.1 200 OK
           Host: some.com
           User-Agent: telnet
           Content-Type: text/html
           Content-Lenght: 11
           Accept: */*

           Hello world
           """
  end

  test "GET /world" do
    request = """
    GET /world HTTP/1.1
    Accept: */*
    Connection: keep-alive
    User-Agent: telnet

    """

    response = Handler.handler(request)

    assert response == """
           HTTP/1.1 200 OK
           Host: some.com
           User-Agent: telnet
           Content-Type: text/html
           Content-Lenght: 14
           Accept: */*

           Hello World!!!
           """
  end

  test "GET /not-found" do
    request = """
    GET /not-found HTTP/1.1
    Accept: */*
    Connection: keep-alive
    User-Agent: telnet

    """

    response = Handler.handler(request)

    assert response == """
           HTTP/1.1 404 Not found
           Host: some.com
           User-Agent: telnet
           Content-Type: text/html
           Content-Lenght: 21
           Accept: */*

           No /not-found found!!
           """
  end

  test "GET /redirectme" do
    request = """
    GET /redirectme HTTP/1.1
    Accept: */*
    Connection: keep-alive
    User-Agent: telnet

    """

    response = Handler.handler(request)

    assert response == """
           HTTP/1.1 404 Not found
           Host: some.com
           User-Agent: telnet
           Content-Type: text/html
           Content-Lenght: 15
           Accept: */*

           No /all found!!
           """
  end

  test "GET /about" do
    request = """
    GET /about HTTP/1.1
    Accept: */*
    Connection: keep-alive
    User-Agent: telnet


    """

    response = Handler.handler(request)

    assert response == """
           HTTP/1.1 200 OK
           Host: some.com
           User-Agent: telnet
           Content-Type: text/html
           Content-Lenght: 128
           Accept: */*

           <h1>About</h1>
           <ul>
               <li>
                   Makingdevs
               </li>
               <li>
                   Agora
               </li>
               <li>
                   Otro
               </li>
           </ul>
           """
  end

  test "POST /new" do
    request = """
    POST /new HTTP/1.1
    Accept: */*
    Connection: keep-alive
    Content-Type: application/x-www-form-urlencoded
    User-Agent: telnet

    name=juan&company=md
    """

    response = Handler.handler(request)

    assert response == """
           HTTP/1.1 201 created
           Host: some.com
           User-Agent: telnet
           Content-Type: text/html
           Content-Lenght: 21
           Accept: */*

           A new element created
           """
  end

  test "GET /developer" do
    request = """
    GET /developer HTTP/1.1
    Accept: */*
    Connection: keep-alive
    Content-Type: application/x-www-form-urlencoded
    User-Agent: telnet

    """

    response = Handler.handler(request)

    assert response === """
           HTTP/1.1 200 OK
           Host: some.com
           User-Agent: telnet
           Content-Type: text/html
           Content-Lenght: 608
           Accept: */*

           <ul>

           <li>1 - Jerri Rubertis</li>

           <li>2 - Lief Gepson</li>

           <li>3 - Viki Van Halle</li>

           <li>4 - Maribelle Dubose</li>

           <li>5 - Vivian Klarzynski</li>

           <li>6 - Helyn Bedome</li>

           <li>7 - Lyndsay Sidney</li>

           <li>8 - Emmye Poluzzi</li>

           <li>9 - Barn Fitzsymons</li>

           <li>10 - Adelheid Muggleston</li>

           <li>11 - Michaela Ginnety</li>

           <li>12 - Cornelle Sebright</li>

           <li>13 - Ivor Corneljes</li>

           <li>14 - Baxter Pitway</li>

           <li>15 - Poul Scullard</li>

           <li>16 - Shaughn Keats</li>

           <li>17 - Slade Sams</li>

           <li>18 - Tarrance Veness</li>

           <li>19 - Brandea Van Brug</li>

           <li>20 - Cloris Godney</li>

           </ul>

           """
  end
end
