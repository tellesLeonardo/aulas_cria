defmodule AulasCria.Core.Authentication.Authentication do
  @moduledoc """
    documentação desse modulo aqui StudentUser
  """

  alias AulasCria.Core.DataBase.Model.{InstructorUser, StudentUser}
  alias AulasCria.Core.Database.Query.{QueryInstructor, QueryStudent}

  require Logger

  def authenticate(%InstructorUser{} = instruct_user), do: !!QueryStudent.get_by_id(instruct_user.id)
  def authenticate(%StudentUser{} = student_user), do: !!QueryStudent.get_by_id(student_user.id)
  def authenticate(_), do: false
end
