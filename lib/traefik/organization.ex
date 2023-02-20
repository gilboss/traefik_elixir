defmodule Traefik.Organization do
  alias Traefik.Developer
  @devs_file Path.expand("./") |> Path.join("MOCK_DATA.csv")
  @offset 0
  @limit 20

  def list_developers(params \\ %{}) do
    @devs_file
    |> File.read!()
    |> String.split("\n")
    |> Kernel.tl()
    |> Enum.map(&String.split(&1, ","))
    |> Enum.map(&transform_developer/1)
    |> Enum.drop(Map.get(params, :offset, @offset))
    |> Enum.take(Map.get(params, :limiit, @limit))
    |> Enum.filter(&(&1 != nil))
  end

  def get_developer(id) when is_binary(id) do
    id
    |> String.to_integer()
    |> get_developer()
  end

  def get_developer(id) when is_integer(id) and id > 0 do
    list_developers()
    |> Enum.find(fn
      nil -> false
      dev -> dev.id == id
    end)
  end

  defp transform_developer([id, first_name, last_name, email, gender, ip]) do
    %Developer{
      id: String.to_integer(id),
      first_name: first_name,
      last_name: last_name,
      email: email,
      gender: gender,
      ip_address: ip
    }
  end

  defp transform_developer(_), do: nil
end
