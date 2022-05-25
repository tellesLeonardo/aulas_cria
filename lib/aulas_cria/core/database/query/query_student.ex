defmodule AulasCria.Core.Database.Query.QueryStudent do
  @moduledoc """
    documentação desse modulo aqui InstructorUser
  """

  alias AulasCria.Core.DataBase.Model.InstructorUser

  def get_all() do
    [%InstructorUser{aluno: "user 1"}, %InstructorUser{aluno: "user 1"}]
  end

  def get_by(_opts_search) do
    %InstructorUser{aluno: "user"}
  end

  def get_per_instructor(_instructor_id) do
    [
      %InstructorUser{aluno: "user 1", instructor: 1},
      %InstructorUser{aluno: "user 2", instructor: 1},
      %InstructorUser{aluno: "user 3", instructor: 1}
    ]
  end

  def update(_student_user, _update_student_user) do
    %InstructorUser{aluno: "user 2"}
  end

  def delete(student_user) do
    :ok
  end

  def create(_params_student_user) do
    %InstructorUser{aluno: "user 4", instructor: 1}
  end
end
