defmodule AulasCria.Core.SdkAws.DynamoItemAdpter do
  @moduledoc false

  import ExAws.Dynamo
  require Logger

  def get(table, search) when is_list(search) do
    get_item(table, search)
    |> ExAws.request()
    |> return()
  end

  def delete(table, search) when is_list(search) do
    delete_item(table, search)
    |> ExAws.request()
    |> return()
  end

  def all(table) do
    scan(table)
    |> ExAws.request()
    |> return()
  end

  def update(table, primary_key, item) do
    case get(table, id: primary_key) do
      %{"Item" => _} ->
        put_item(table, item)
        |> ExAws.request()
        |> return()

      %{} ->
        {:error, :item_not_exist}
    end
  end

  def create(table, %{} = item) do
    put_item(table, item)
    |> ExAws.request()
    |> return()
  end

  def execute_query(table, query) when is_list(query) do
    scan(table, query)
    |> ExAws.request()
  end

  defp return({:ok, data}), do: data

  defp return({:error, error}) do
    Logger.error("#{__MODULE__} erro: #{inspect(error)} ")
    {:error, error}
  end
end
