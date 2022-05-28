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

  def update(table, item) do
    case get(table, id: item.id) do
      {:ok, %{}} ->
        {:error, :item_not_exist}

      {:ok, %{"Item" => _}} ->
        put_item(table, item)
        |> ExAws.request()
        |> return()
    end
  end

  def create(table, %{} = item) do
    put_item(table, item)
    |> ExAws.request()
    |> return()
  end

  defp return({:ok, data}), do: data

  defp return({:error, error}) do
    Logger.error("#{__MODULE__} erro: #{inspect(error)} ")
    {:error, error}
  end
end
