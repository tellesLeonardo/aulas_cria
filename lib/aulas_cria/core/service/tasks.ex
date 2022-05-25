defmodule AulasCria.Core.Service.Tasks do
  @moduledoc """
    documentação desse modulo aqui InstructorUser
  """

  alias AulasCria.Core.Authentication.Authentication
  alias AulasCria.Core.Database.Query.QueryTasks

  def get_all(requester) do
    case Authentication.authenticate(requester, nil) do
      true -> {:ok, QueryTasks.get_all()}
      false -> {:error, :not_authorized}
    end
  end

  def get_id(requester, task_is) do
    case Authentication.authenticate(requester, nil) do
      true -> {:ok, QueryTasks.get_id(task_is)}
      false -> {:error, :not_authorized}
    end
  end

  def create(requester, params_task) do
    case Authentication.authenticate(requester, nil) do
      true -> {:ok, QueryTasks.create(params_task)}
      false -> {:error, :not_authorized}
    end
  end

  def delete(requester, task) do
    case Authentication.authenticate(requester, nil) do
      true -> {:ok, QueryTasks.delete(task)}
      false -> {:error, :not_authorized}
    end
  end

  def update(requester, tasks, update_tasks) do
    case Authentication.authenticate(requester, nil) do
      true -> {:ok, QueryTasks.update(tasks, update_tasks)}
      false -> {:error, :not_authorized}
    end
  end
end
