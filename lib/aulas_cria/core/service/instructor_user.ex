defmodule AulasCria.Core.Service.InstructorUser do
  @moduledoc """
    documentação desse modulo aqui InstructorUser
  """

  alias AulasCria.Core.Authentication.Authentication
  alias AulasCria.Core.Database.Query.QueryInstructor

  def get_all(requester) do
    case Authentication.authenticate(requester) do
      true -> {:ok, QueryInstructor.get_all()}
      false -> {:error, :not_authorized}
    end
  end

  def get_by_id(requester, instructor_id) do
    case Authentication.authenticate(requester) do
      true -> {:ok, QueryInstructor.get_by_id(instructor_id)}
      false -> {:error, :not_authorized}
    end
  end

  def get_per_instructor(requester, instructor_id) do
    case Authentication.authenticate(requester) do
      true -> {:ok, QueryInstructor.get_per_instructor(instructor_id)}
      false -> {:error, :not_authorized}
    end
  end

  def update(requester, instructor_id, update_instructor_user) do
    case Authentication.authenticate(requester) do
      true -> {:ok, QueryInstructor.update(instructor_id, update_instructor_user)}
      false -> {:error, :not_authorized}
    end
  end

  def delete(requester, instructor_user) do
    case Authentication.authenticate(requester) do
      true -> {:ok, QueryInstructor.delete(instructor_user.id)}
      false -> {:error, :not_authorized}
    end
  end

  def create(requester, params_instructor_user) do
    case Authentication.authenticate(requester) do
      true -> {:ok, QueryInstructor.create(params_instructor_user)}
      false -> {:error, :not_authorized}
    end
  end
end
