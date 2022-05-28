defmodule AulasCria.Core.SdkAws.DybanoTableAdpter do
  @moduledoc false

  # Tables
  import ExAws.Dynamo
  require Logger

  def all() do
    list_tables()
    |> ExAws.request()
    |> return()
  end

  defp return({:ok, data}), do: data

  defp return({:error, error}) do
    Logger.error("#{__MODULE__} erro: #{inspect(error)} ")
    {:error, error}
  end
end
