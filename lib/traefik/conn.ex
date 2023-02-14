defmodule Traefik.Conn do
  defstruct method: "", path: "", response: "", status: nil

  def status(%__MODULE__{} = conn) do
    "#{conn.status} #{status_reason(conn.status)}"
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
