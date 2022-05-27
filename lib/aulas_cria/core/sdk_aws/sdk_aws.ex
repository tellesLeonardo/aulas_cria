defmodule AulasCria.Core.SdkAws do
  @moduledoc false

  use GenServer

  alias AulasCria.Core.SdkAws.Clients.Client

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
          client: Client.create_or_acess()
        }
      })

    {:noreply, state}
  end

  @impl true
  def handle_call(_event, _from, state) do
    IO.inspect(state, label: "1")
    {:reply, nil, state}
  end

  @impl true
  def handle_cast(_event, state) do
    {:noreply, state}
  end

  def call(event, opts \\ []) do
    timeout = Keyword.get(opts, :timeout) || @timeout

    GenServer.call(:persistent_process, {event, opts}, timeout)
  end
end
