defmodule AulasCria.Core.Database.Query.QueryTasks do
  @moduledoc """
    documentação desse modulo aqui InstructorUser
  """

  alias AulasCria.Core.DataBase.Model.Tasks

  def get_all() do
    [%Tasks{title: "sub"}, %Tasks{title: "sub 1"}, %Tasks{title: "sub 2"}]
  end

  def get_id(_opts_search) do
    %Tasks{title: "sub 1"}
  end

  def update(_student_user, _update_student_user) do
    %Tasks{title: "sub update"}
  end

  def delete(task) do
    :ok
  end

  def create(_params_student_user) do
    %Tasks{title: "sub"}
  end
end
