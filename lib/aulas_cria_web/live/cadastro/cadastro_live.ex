defmodule AulasCriaWeb.Live.Cadastro.CadastroLive do
  use Phoenix.LiveView

  def render(assigns) do
    Phoenix.View.render(AulasCriaWeb.CadastroView, "cadastro.html", assigns)
  end

  def mount(params, session, socket) do
    params |> IO.inspect(label: "unica")
    session |> IO.inspect(label: "pessoa")

    {:ok, assign(socket, user: %{})}
  end
end

# def create2(conn, %{"user" => user_params}) do
#   user_params = Map.put(user_params, "id", user_params["username"])

#   case user_params["student"] do
#     "true" ->
#       StudentUser.create(user_params)

#       conn
#       |> put_session(:current_user_id, user_params["id"])
#       |> put_session(:type_user, :student)
#       |> put_flash(:info, "Signed up successfully.")
#       |> redirect(to: Routes.live_path(conn, AulasLive))

#     "false" ->
#       InstructorUser.create(user_params)

#       conn
#       |> put_session(:current_user_id, user_params["id"])
#       |> put_session(:type_user, :instructor)
#       |> put_flash(:info, "Signed up successfully.")
#       |> redirect(to: Routes.live_path(conn, AulasLive))
#   end
# end
