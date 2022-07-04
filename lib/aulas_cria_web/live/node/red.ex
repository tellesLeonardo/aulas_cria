defmodule AulasCriaWeb.Live.Node.Red do
  use Phoenix.LiveView

  def render(assigns) do
    Phoenix.View.render(AulasCriaWeb.NodeView, "index.html", assigns)
  end

  def mount(_params, _session, socket) do
    {:ok,
     assign(socket,
       status: true,
       cl2: 0,
       no2: 0,
       co2: 0,
       r22: 0
     )}
  end

  def handle_event("validate", %{"cl2" => cl2, "co2" => co2, "no2" => no2, "r22" => r22}, socket) do
    {:noreply,
     assign(socket,
       cl2: cl2,
       no2: no2,
       co2: co2,
       r22: r22
     )}
  end
end
