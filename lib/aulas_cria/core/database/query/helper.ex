defmodule AulasCria.Core.Database.Query.Helper do
  @moduledoc false

  def formater_result(map) when is_map(map) do
    map
    |> Enum.map(fn {key, tes} ->
      tes =
        tes
        |> Map.values()
        |> hd()
        |> recursived()

      {key, tes}
    end)
    |> Map.new()
  end

  def formater_result(map), do: map

  def recursived(item) when is_list(item) do
    item
    |> Enum.map(fn item ->
      Enum.map(item, fn {_key, tes} -> formater_result(tes) end)
      |> List.wrap()
      |> hd()
    end)
  end

  def recursived(item), do: item
end
