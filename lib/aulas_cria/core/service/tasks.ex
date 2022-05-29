defmodule AulasCria.Core.Service.Tasks do
  @moduledoc """
    documentação desse modulo aqui InstructorUser
  """

  alias AulasCria.Core.Authentication.Authentication
  alias AulasCria.Core.Database.Query.QueryTasks

  def get_all(requester) do
    case Authentication.authenticate(requester) do
      true -> {:ok, QueryTasks.get_all()}
      false -> {:error, :not_authorized}
    end
  end

  def get_id(requester, task_id) do
    case Authentication.authenticate(requester) do
      true -> {:ok, QueryTasks.get_id_id(task_id)}
      false -> {:error, :not_authorized}
    end
  end

  def create(requester, params_task) do
    case Authentication.authenticate(requester) do
      true -> {:ok, QueryTasks.create(params_task)}
      false -> {:error, :not_authorized}
    end
  end

  def delete(requester, task) do
    case Authentication.authenticate(requester) do
      true -> {:ok, QueryTasks.delete(task.id)}
      false -> {:error, :not_authorized}
    end
  end

  def update(requester, tasks_id, update_tasks) do
    case Authentication.authenticate(requester) do
      true -> {:ok, QueryTasks.update(tasks_id, update_tasks)}
      false -> {:error, :not_authorized}
    end
  end
end
