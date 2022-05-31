defmodule AulasCriaWeb.Helpers.Auth do
  alias AulasCria.Core.Database.Query.QueryInstructor
  alias AulasCria.Core.Database.Query.QueryStudent

  def signed_in?(conn) do
    user_id = Plug.Conn.get_session(conn, :current_user_id)
    type_user = Plug.Conn.get_session(conn, :type_user)

    case type_user do
      :instructor -> if user_id, do: !!QueryInstructor.get_by_id(user_id)
      :student -> if user_id, do: !!QueryStudent.get_by_id(user_id)
      nil -> false
    end
  end
end
