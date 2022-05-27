defmodule AulasCria.Core.Database.Query.QueryInstructor do
  @moduledoc """
    documentação desse modulo aqui InstructorUser
  """

  alias AulasCria.Core.DataBase.Model.InstructorUser

  def get_all() do
    [%InstructorUser{name: "profe 1"}, %InstructorUser{name: "profe 1"}]
  end

  def get_by(_opts_search) do
    %InstructorUser{name: "professor"}
  end

  def get_per_instructor(_instructor_id) do
    [
      %InstructorUser{name: "profe 1"},
      %InstructorUser{name: "profe 2"},
      %InstructorUser{name: "profe 3"}
    ]
  end

  def update(_instructor_user, _update_instructor_user) do
    %InstructorUser{name: "profe 2"}
  end

  def delete(instructor_user) do
    :ok
  end

  def create(_params_instructor_user) do
    %InstructorUser{name: "profe 4"}
  end
end
