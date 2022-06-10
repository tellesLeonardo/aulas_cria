defmodule AulasCriaWeb.Live.Cadastro.CadastroLive do
  use Phoenix.LiveView

  alias AulasCriaWeb.Router.Helpers, as: Routes
  alias AulasCria.Core.DataBase.Model.User
  alias AulasCria.Core.SdkAws
  alias AulasCria.Core.Service.{InstructorUser, StudentUser}

  def render(assigns) do
    Phoenix.View.render(AulasCriaWeb.CadastroView, "cadastro.html", assigns)
  end

  def mount(_params, _session, socket) do
    socket =
      assign(socket,
        step: 1,
        profile: "student",
        user_params: nil,
        changeset: User.change_user(),
        security: 0
      )
      |> allow_upload(:background, accept: ~w(.jpg .jpeg .png), max_entries: 1, auto_upload: true)
      |> allow_upload(:avatar, accept: ~w(.jpg .jpeg .png), max_entries: 1, auto_upload: true)

    {:ok, socket}
  end

  def handle_event("next", _, socket) do
    step = socket.assigns.step + 1

    {:noreply,
     assign(socket,
       step: step
     )}
  end

  def handle_event("back", _, socket) do
    step = socket.assigns.step - 1

    {:noreply,
     assign(socket,
       step: step
     )}
  end

  def handle_event("choice-profile", %{"choice" => choice}, socket) do
    {:noreply,
     assign(socket,
       profile: choice
     )}
  end

  def handle_event("validate", %{"user" => user}, socket) do
    user = create_date(user)

    changeset =
      %User{}
      |> User.changeset(user)
      |> Map.put(:action, :insert)

    {:noreply,
     assign(socket,
       changeset: changeset,
       user_params: user
     )}
  end

  def handle_event("valide-password", %{"password" => %{"password" => password}}, socket) do
    security =
      [
        String.match?(password, ~r/[A-Z]/),
        String.match?(password, ~r/[a-z]/),
        String.match?(password, ~r/[0-9]/),
        String.match?(password, ~r/[!@#$%^&*(),.?":{}|<>]/)
      ]
      |> Enum.count(& &1)

    user_params = Map.put(socket.assigns.user_params || %{}, "password", password)

    {:noreply, assign(socket, security: security, user_params: user_params)}
  end

  def handle_event("save", _, socket) do
    link_avatar = insert_s3(socket, :avatar)
    background = insert_s3(socket, :background)

    user_params =
      Map.merge(socket.assigns.user_params, %{
        "picture" => link_avatar,
        "background" => background
      })

    case socket.assigns.profile do
      "student" -> StudentUser.create(user_params)
      "instructor" -> InstructorUser.create(user_params)
    end

    {:noreply, assign(socket, step: 4, user_params: user_params)}
  end

  defp insert_s3(socket, field) do
    consume_uploaded_entries(socket, field, fn %{path: path}, entry ->
      ext = Path.extname(entry.client_name)

      name_img = entry.client_name <> ext

      SdkAws.cast({:save_image, name_img, File.read!(path)})
      SdkAws.call({:get_image, name_img})
    end)
    |> List.first()
    |> IO.inspect(label: "vulcani")
  end

  defp create_date(user) do
    yeaer = String.to_integer(user["yeaer"])
    month = String.to_integer(user["month"])
    day = String.to_integer(user["day"])

    {:ok, date} = Date.new(yeaer, month, day)

    Map.merge(user, %{"id" => user["username"], "birthday" => Date.to_string(date)})
  end
end
