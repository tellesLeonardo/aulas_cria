defmodule AulasCria.Core.Service.Tasks do
  @moduledoc """
    documentação desse modulo aqui InstructorUser
  """

  alias AulasCria.Core.Authentication.Authentication
  alias AulasCria.Core.Database.Query.QueryTasks
  alias AulasCria.Core.DataBase.Model.Tasks


  @spec get_all(InstructorUser.t() | StudentUser.t() ) :: {:ok, list(Tasks.t())} | {:error, :not_authorized}
  def get_all(requester) do
    case Authentication.authenticate(requester) do
      true -> {:ok, QueryTasks.get_all()}
      false -> {:error, :not_authorized}
    end
  end

  @spec get_id(InstructorUser.t() | StudentUser.t()) :: {:ok, Tasks.t()} | {:error, :not_authorized}
  def get_id(requester, task_is) do
    case Authentication.authenticate(requester) do
      true -> {:ok, QueryTasks.get_id(task_is)}
      false -> {:error, :not_authorized}
    end
  end

  @spec create(InstructorUser.t() ) :: {:ok, Tasks.t()} | {:error, :not_authorized}
  def create(requester, params_task) do
    case Authentication.authenticate(requester) do
      true -> {:ok, QueryTasks.create(params_task)}
      false -> {:error, :not_authorized}
    end
  end

  @spec delete(InstructorUser.t() ) :: {:ok, ok} | {:error, :not_authorized}
  def delete(requester, task) do
    case Authentication.authenticate(requester) do
      true -> {:ok, QueryTasks.delete(task)}
      false -> {:error, :not_authorized}
    end
  end

  @spec update(InstructorUser.t()) :: {:ok, Tasks.t()} | {:error, :not_authorized}
  def update(requester, tasks, update_tasks) do
    case Authentication.authenticate(requester) do
      true -> {:ok, QueryTasks.update(tasks, update_tasks)}
      false -> {:error, :not_authorized}
    end
  end
end
