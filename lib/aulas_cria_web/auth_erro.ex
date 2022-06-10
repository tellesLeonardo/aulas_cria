defmodule AulasCriaWeb.AuthHandler do
  @moduledoc false

  use AulasCriaWeb, :controller
  alias Plug.Conn
  alias AulasCriaWeb.Live.Aulas.AulasLive
  alias AulasCriaWeb.Helpers.Auth

  @spec call(Conn.t(), atom()) :: Conn.t()
  def call(conn, []) do
    auth = Auth.signed_in?(conn)

    cond do
      auth == true ->
        conn
        |> redirect(to: Routes.live_path(conn, AulasLive))

      auth in [false, nil] ->
        conn
        |> redirect(to: Routes.session_path(conn, :index))
    end
  end
end
