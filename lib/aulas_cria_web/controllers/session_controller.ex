defmodule AulasCriaWeb.SessionController do
  use AulasCriaWeb, :controller

  alias AulasCria.Core.Service.{InstructorUser, StudentUser}
  alias AulasCria.Core.Database.Query.{QueryInstructor, QueryStudent}
  alias AulasCria.Core.DataBase.Model.User
  alias AulasCriaWeb.Live.Aulas.AulasLive

  def index(conn, _params) do
    render(conn, "app.html")
  end

  def new(conn, params) do
    type_user =
      params
      |> Map.get("type_user", "student")
      |> String.to_atom()

    render(conn, "new.html", type_user: type_user)
  end

  def new2(conn, _params) do
    changeset = User.change_user(%User{})
    render(conn, "new2.html", changeset: changeset)
  end

  def create(conn, %{"session" => auth_params}) do
    case request_user(auth_params["type_user"], auth_params["username"], auth_params["password"]) do
      true ->
        conn
        |> put_session(:current_user_id, auth_params["username"])
        |> put_session(:type_user, String.to_atom(auth_params["type_user"]))
        |> put_flash(:info, "Signed in successfully.")
        |> redirect(to: Routes.live_path(conn, AulasLive))

      false ->
        conn
        |> put_flash(:error, "There was a problem with your username/password")
        |> render("new.html", type_user: String.to_atom(auth_params["type_user"]))
    end
  end

  defp request_user("student", username, password) do
    case QueryStudent.get_by_id(username) do
      nil -> false
      %{password: user_password} -> user_password == password
    end
  end

  defp request_user("instructor", username, password) do
    case QueryInstructor.get_by_id(username) do
      nil -> false
      %{password: user_password} -> user_password == password
    end
  end

  def create2(conn, %{"user" => user_params}) do
    user_params = Map.put(user_params, "id", user_params["username"])

    case user_params["student"] do
      "true" ->
        StudentUser.create(user_params)

        conn
        |> put_session(:current_user_id, user_params["id"])
        |> put_session(:type_user, :student)
        |> put_flash(:info, "Signed up successfully.")
        |> redirect(to: Routes.live_path(conn, AulasLive))

      "false" ->
        InstructorUser.create(user_params)

        conn
        |> put_session(:current_user_id, user_params["id"])
        |> put_session(:type_user, :instructor)
        |> put_flash(:info, "Signed up successfully.")
        |> redirect(to: Routes.live_path(conn, AulasLive))
    end
  end

  def delete(conn, _params) do
    conn
    |> delete_session(:current_user_id)
    |> put_flash(:info, "Signed out successfully.")
    |> redirect(to: Routes.registration_path(conn, :index))
  end
end
