defmodule AulasCriaWeb.RegistrationController do
  use AulasCriaWeb, :controller

  def index(conn, _params) do
    render(conn, "app.html")
  end
end
