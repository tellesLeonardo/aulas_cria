defmodule AulasCriaWeb.Live.Aulas.AulasLive do
  use Phoenix.LiveView

  # alias AulasCria.PubSub
  alias AulasCria.Core.DataBase.Model.InstructorUser
  alias AulasCria.Core.Service.InstructorUser, as: InstructorUserService
  alias AulasCria.Core.Service.StudentUser, as: StudentUserService
  alias AulasCria.Core.Database.Query.{QueryInstructor, QueryStudent}

  def render(assigns) do
    Phoenix.View.render(AulasCriaWeb.AulasView, "aulas.html", assigns)
  end

  def mount(_params, session, socket) do
    IO.inspect(%{type_user: session["type_user"], current_user_id: session["current_user_id"]})

    user = request_user(session["type_user"], session["current_user_id"])

    {:ok, tasks} = AulasCria.Core.Service.Tasks.get_all(user)

    {:ok,
     assign(socket,
       tasks: tasks,
       user: user,
       init: true,
       interests: false,
       categories: get_categories(user),
       list_interest: [],
       search_tasks: []
     )}
  end

  def handle_event("no-init", _, socket) do
    {:noreply, assign(socket, init: false)}
  end

  def handle_event("my-interests", _, socket) do
    {:noreply, assign(socket, interests: true, list_interest: list_interest())}
  end

  def handle_event("close-interests", _, socket) do
    {:noreply, assign(socket, interests: false)}
  end

  def handle_event("save-interests", _, socket) do
    update(socket.assigns.user)

    {:noreply, assign(socket, interests: false)}
  end

  def handle_event("search-task", %{"search" => %{"search_task" => search_task}}, socket) do
    search_tasks =
      socket.assigns.tasks
      |> Enum.filter(fn %{title: title} ->
        String.contains?(title, [search_task])
      end)

    {:noreply, assign(socket, search_tasks: search_tasks)}
  end

  def handle_event("add_interest", %{"id" => id}, socket) do
    interests = socket.assigns.user.interests

    item = Enum.find(socket.assigns.list_interest, &(&1.id == id))

    interests =
      cond do
        length(interests) == 4 ->
          {_, list_interests} = List.pop_at(interests, 0)

          list_interests ++ [item]

        length(interests) < 4 ->
          interests ++ [item]
      end
      |> Enum.uniq()

    user = %{socket.assigns.user | interests: interests}

    {:noreply, assign(socket, user: user)}
  end

  defp request_user(:student, username), do: QueryStudent.get_by_id(username)
  defp request_user(:instructor, username), do: QueryInstructor.get_by_id(username)

  defp update(%InstructorUser{} = user) do
    InstructorUserService.update(user, user.id, user)
  end

  defp update(user) do
    StudentUserService.update(user, user.id, user)
  end

  defp list_interest() do
    [
      %{
        image: "/images/tabler_math-symbols.svg",
        title: "Matemática",
        discription: "Estudo da Álgebra",
        id: "mat-alg"
      },
      %{
        image: "/images/Vector.svg",
        title: "Literatura",
        discription: "literatura de programação",
        id: "lit-pro"
      },
      %{
        image: "/images/Group_48.svg",
        title: "Quântico",
        discription: "Programação quântica",
        id: "qua-pro"
      },
      %{
        image: "/images/diagramme_de_venn_venn_diagram.svg",
        title: "Conjuntos",
        discription: "Conjuntos numéricos",
        id: "con-num"
      },
      %{
        image: "/images/robot-toy-flat-by-Vexels.svg",
        title: "Robótica",
        discription: "robótica aplicada",
        id: "rob-alp"
      }
    ]
  end

  defp get_categories(%{tasks: tasks}) when is_list(tasks) do
    interestes = list_interest()

    tasks
    |> Enum.map(fn item ->
      return = Enum.find(interestes, &(&1.title == item["category"]))

      Map.put(item, "image", return.image)
    end)
  end

  defp get_categories(_), do: []
end
