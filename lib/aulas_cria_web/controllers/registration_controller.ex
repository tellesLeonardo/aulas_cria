defmodule AulasCriaWeb.RegistrationController do
  use AulasCriaWeb, :controller

  alias AulasCria.Core.Service.{InstructorUser, StudentUser}
  alias AulasCria.Core.DataBase.Model.InstructorUser, as: ModelInstructorUser
  alias AulasCria.Core.DataBase.Model.User
  alias AulasCriaWeb.Live.Aulas.AulasLive

  def index(conn, _params) do
    render(conn, "app.html")
  end
end
