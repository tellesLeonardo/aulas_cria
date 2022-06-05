defmodule AulasCria.Core.SdkAws do
  @moduledoc false

  use GenServer

  @timeout 60_000

  def start_link(args) do
    GenServer.start_link(__MODULE__, args, name: :persistent_process)
  end

  @impl true
  def init(state) do
    {:ok, state, {:continue, :initializing}}
  end

  @impl true
  def handle_continue(:initializing, state) do
    state =
      Map.merge(state, %{
        aws: %{
          tables: adapter_dynamo_struct().all()
        }
      })

    {:noreply, state}
  end

  @impl true
  def handle_call({:get, table, search}, _from, state) do
    {:reply, valid_table(state.aws.tables, table, fn -> adapter_dynamo().get(table, search) end),
     state}
  end

  @impl true
  def handle_call({:delete, table, search}, _from, state) do
    {:reply,
     valid_table(state.aws.tables, table, fn -> adapter_dynamo().delete(table, search) end),
     state}
  end

  @impl true
  def handle_call({:all, table}, _from, state) do
    {:reply, valid_table(state.aws.tables, table, fn -> adapter_dynamo().all(table) end), state}
  end

  @impl true
  def handle_call({:update, table, primary_key, item}, _from, state) do
    {:reply,
     valid_table(state.aws.tables, table, fn ->
       adapter_dynamo().update(table, primary_key, item)
     end), state}
  end

  @impl true
  def handle_call({:create, table, item}, _from, state) do
    {:reply, valid_table(state.aws.tables, table, fn -> adapter_dynamo().create(table, item) end),
     state}
  end

  @impl true
  def handle_call(:tables, _from, state) do
    state =
      Map.merge(state, %{
        aws: %{
          tables: adapter_dynamo_struct().all()
        }
      })

    {:reply, state.aws.tables, state}
  end

  @impl true
  def handle_call({:get_image, path}, _from, state) do
    {:ok, link} =
      adapter_s3().make_presigned_url(
        Application.get_env(:ex_aws, :s3)[:bucket],
        Path.basename(path)
      )

    {:reply, link, state}
  end

  @impl true
  def handle_cast({:save_image, path, binary}, state) do
    {:ok, _finish} =
      adapter_s3().upload_file(
        Application.get_env(:ex_aws, :s3)[:bucket],
        Path.basename(path),
        binary
      )

    {:noreply, state}
  end

  @impl true
  def handle_cast(_event, state) do
    IO.inspect(state)
    {:noreply, state}
  end

  def call(event, timeout \\ @timeout) do
    GenServer.call(:persistent_process, event, timeout)
  end

  def cast(event) do
    GenServer.cast(:persistent_process, event)
  end

  defp adapter_dynamo(), do: AulasCria.Core.SdkAws.DynamoItemAdpter
  defp adapter_dynamo_struct(), do: AulasCria.Core.SdkAws.DybanoTableAdpter
  defp adapter_s3(), do: AulasCria.Core.SdkAws.S3

  defp valid_table(%{"TableNames" => tables_valid}, table, function) do
    case table in tables_valid do
      true -> function.()
      false -> :error_table_invalid
    end
  end
end
