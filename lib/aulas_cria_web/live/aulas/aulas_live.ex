defmodule AulasCriaWeb.Live.Aulas.AulasLive do
  use Phoenix.LiveView

  # alias AulasCria.PubSub
  # alias AulasCria.Core.DataBase.Model.InstructorUser
  alias AulasCria.Core.Database.Query.{QueryInstructor, QueryStudent}

  def render(assigns) do
    Phoenix.View.render(AulasCriaWeb.AulasView, "aulas.html", assigns)
  end

  def mount(_params, session, socket) do
    user = request_user(session["type_user"], session["current_user_id"])

    {:ok, tasks} = AulasCria.Core.Service.Tasks.get_all(user)

    {:ok, assign(socket, tasks: tasks, user: user)}
  end

  def handle_event(_event, _, socket) do
    IO.puts("arthuszin")
    {:noreply, socket}
  end

  defp request_user(:student, username), do: QueryStudent.get_by_id(username)
  defp request_user(:instructor, username), do: QueryInstructor.get_by_id(username)
end
