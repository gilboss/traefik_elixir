defmodule Traefik.DeveloperController do
  alias Traefik.Conn
  alias Traefik.Organization

  def index(%Conn{} = conn) do
    developers =
      Organization.list_developers()
      |> Enum.map(fn d -> "<li>#{d.id} #{d.first_name}</li>" end)
      |> Enum.join("\n")

    developers = "
    <ul>
    #{developers}
    </ul>
    "

    %{conn | response: developers, status: 200}
  end

  def show(%Conn{} = conn, %{"id" => id}) do
    developer = Organization.get_developer(id)

    dev_response = """
    #{developer.id} - #{developer.first_name} - #{developer.last_name} - #{developer.email}
    """

    %{conn | response: dev_response, status: 200}
  end

  defp render(conn, template, bindings) do
    response =
      Path.expand("../../templates", __DIR__)
      |> Path.join(template)
      |> EEx.eval_file(bindings)

    %{conn | response: response, status: 200}
  end
end
