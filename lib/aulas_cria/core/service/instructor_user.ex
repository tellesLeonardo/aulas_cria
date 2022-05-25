defmodule AulasCria.Core.Service.InstructorUser do
  @moduledoc """
    documentação desse modulo aqui InstructorUser
  """

  alias AulasCria.Core.Authentication.Authentication
  alias AulasCria.Core.Database.Query.QueryInstructor
  alias AulasCria.Core.DataBase.Model.InstructorUser

  @spec get_all(InstructorUser.t()) :: {:ok, list(InstructorUser.t())} | {:error, :not_authorized}
  def get_all(requester) do
    case Authentication.authenticate(requester) do
      true -> {:ok, QueryInstructor.get_all()}
      false -> {:error, :not_authorized}
    end
  end

  def get_by(requester, opts_search) do
    case Authentication.authenticate(requester, nil) do
      true -> {:ok, QueryInstructor.get_by(opts_search)}
      false -> {:error, :not_authorized}
    end
  end

  def get_per_instructor(requester, instructor_id) do
    case Authentication.authenticate(requester, nil) do
      true -> {:ok, QueryInstructor.get_per_instructor(instructor_id)}
      false -> {:error, :not_authorized}
    end
  end

  def update(requester, student_user, update_student_user) do
    case Authentication.authenticate(requester, nil) do
      true -> {:ok, QueryInstructor.update(student_user, update_student_user)}
      false -> {:error, :not_authorized}
    end
  end

  def delete(requester, student_user) do
    case Authentication.authenticate(requester, nil) do
      true -> {:ok, QueryInstructor.delete(student_user)}
      false -> {:error, :not_authorized}
    end
  end

  def create(requester, params_student_user) do
    case Authentication.authenticate(requester, nil) do
      true -> {:ok, QueryInstructor.create(params_student_user)}
      false -> {:error, :not_authorized}
    end
  end
end
