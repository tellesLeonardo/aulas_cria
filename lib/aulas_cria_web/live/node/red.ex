defmodule AulasCriaWeb.Live.Node.Red do
  use Phoenix.LiveView

  @topic "Sensor/Doku"

  def render(assigns) do
    Phoenix.View.render(AulasCriaWeb.NodeView, "index.html", assigns)
  end

  def mount(_params, _session, socket) do
    emqtt_opts = Application.get_env(:node_red, :emqtt)
    {:ok, pid} = :emqtt.start_link(emqtt_opts)
    {:ok, _} = :emqtt.connect(pid)

    {:ok, _, _} = :emqtt.subscribe(pid, @topic)

    {:ok,
     assign(socket,
       status: true,
       pid: pid,
       cl2: 0,
       no2: 0,
       co2: 0,
       r22: 0
     )}
  end

  def handle_event("validate", %{"cl2" => cl2, "co2" => co2, "no2" => no2, "r22" => r22}, socket) do
    payload = %{
      home: "PythonHouse",
      email: "amanda99@ucl.br",
      cl2: %{initials: "CL2", name: "Cloro", level: cl2},
      no2: %{initials: "NO2", name: "Dióxido de Nitrogênio", level: no2},
      r22: %{initials: "R22", name: "Clorodifluorometano", level: r22},
      co2: %{initials: "CO2", name: "Monóxido de Carbono", level: co2},
      status: Timex.now() |> Timex.to_unix()
    }

    :ok =
      :emqtt.publish(
        socket.assigns.pid,
        @topic,
        payload
      )

    {:noreply,
     assign(socket,
       cl2: cl2,
       no2: no2,
       co2: co2,
       r22: r22
     )}
  end

  def handle_info({:publish, packet}, socket) do
    parse_topic(packet) |> IO.inspect(label: "teste")
    packet |> IO.inspect(label: "teste2")
  end

  defp parse_topic(%{topic: topic}) do
    String.split(topic, "/", trim: true)
  end
end
