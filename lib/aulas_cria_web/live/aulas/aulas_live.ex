defmodule AulasCriaWeb.Live.Aulas.AulasLive do
  use Phoenix.LiveView

  alias AulasCria.PubSub
  alias AulasCria.Core.DataBase.Model.InstructorUser

  def render(assigns) do
    Phoenix.View.render(AulasCriaWeb.AulasView, "aulas.html", assigns)
  end

  def mount(params, session, socket) do
    params |> IO.inspect(label: "params")
    session |> IO.inspect(label: "session")

    {:ok, tasks} = AulasCria.Core.Service.Tasks.get_all(%InstructorUser{})

    {:ok, assign(socket, tasks: tasks, user: %{id: "seila"})}
  end

  def handle_event(:insert_pub_sub, _, socket) do
    IO.puts("caht")
    PubSub.subscribe(:my_pubsub, "user:#{socket.assigns.user.id}")

    {:noreply, socket}
  end

  def handle_event(_event, _, socket) do
    IO.puts("arthuszin")
    {:noreply, socket}
  end
end
