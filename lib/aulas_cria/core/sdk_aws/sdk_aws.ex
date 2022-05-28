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
  def handle_call({event, module}, _from, state) do
    module |> IO.inspect()

    cond do
      module == :dynamo_db ->
        redirect(adapter_dynamo(), event, state)

      module == :ec2 ->
        redirect(adapter_s3(), event, state)

      true ->
        "no correspondent"
    end

    {:reply, nil, state}
  end

  @impl true
  def handle_cast(_event, state) do
    {:noreply, state}
  end

  def call(event, opts \\ []) do
    timeout = Keyword.get(opts, :timeout) || @timeout

    GenServer.call(:persistent_process, event, timeout)
  end

  defp redirect(adapter, :get, state), do: adapter.get(state.aws.client)
  defp redirect(adapter, :delete, state), do: adapter.delete(state.aws.client)
  defp redirect(adapter, :all, state), do: adapter.all(state.aws.client)
  defp redirect(adapter, :update, state), do: adapter.update(state.aws.client)
  defp redirect(adapter, :create, state), do: adapter.create(state.aws.client)

  def adapter_dynamo(), do: AulasCria.Core.SdkAws.DynamoItemAdpter
  def adapter_dynamo_struct(), do: AulasCria.Core.SdkAws.DybanoTableAdpter
  def adapter_s3(), do: AulasCria.Core.SdkAws.S3
end
