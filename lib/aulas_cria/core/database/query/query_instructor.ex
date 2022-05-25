defmodule AulasCria.Core.Database.Query.QueryInstructor do
  @moduledoc """
    documentação desse modulo aqui InstructorUser
  """

  alias AulasCria.Core.DataBase.Model.InstructorUser

  def get_all() do
    [%InstructorUser{aluno: "profe 1"}, %InstructorUser{aluno: "profe 1"}]
  end

  def get_by(_opts_search) do
    %InstructorUser{aluno: "professor"}
  end

  def get_per_instructor(_instructor_id) do
    [
      %InstructorUser{aluno: "profe 1", instructor: 1},
      %InstructorUser{aluno: "profe 2", instructor: 1},
      %InstructorUser{aluno: "profe 3", instructor: 1}
    ]
  end

  def update(_instructor_user, _update_instructor_user) do
    %InstructorUser{aluno: "profe 2"}
  end

  def delete(instructor_user) do
    :ok
  end

  def create(_params_instructor_user) do
    %InstructorUser{aluno: "profe 4", instructor: 1}
  end
end
