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

  @spec get_by(InstructorUser.t()) :: {:ok, InstructorUser.t()} | {:error, :not_authorized}
  def get_by(requester, opts_search) do
    case Authentication.authenticate(requester) do
      true -> {:ok, QueryInstructor.get_by(opts_search)}
      false -> {:error, :not_authorized}
    end
  end
  @spec get_per_instructor(InstructorUser.t()) :: {:ok, InstructorUser.t()} | {:error, :not_authorized}
  def get_per_instructor(requester, instructor_id) do
    case Authentication.authenticate(requester) do
      true -> {:ok, QueryInstructor.get_per_instructor(instructor_id)}
      false -> {:error, :not_authorized}
    end
  end

  @spec update(InstructorUser.t()) :: {:ok, InstructorUser.t()} | {:error, :not_authorized}
  def update(requester, student_user, update_student_user) do
    case Authentication.authenticate(requester) do
      true -> {:ok, QueryInstructor.update(student_user, update_student_user)}
      false -> {:error, :not_authorized}
    end
  end

  @spec delete(InstructorUser.t()) :: {:ok, ok} | {:error, :not_authorized}
  def delete(requester, student_user) do
    case Authentication.authenticate(requester) do
      true -> {:ok, QueryInstructor.delete(student_user)}
      false -> {:error, :not_authorized}
    end
  end

  @spec create(InstructorUser.t()) :: {:ok, InstructorUser.t()} | {:error, :not_authorized}
  def create(requester, params_student_user) do
    case Authentication.authenticate(requester) do
      true -> {:ok, QueryInstructor.create(params_student_user)}
      false -> {:error, :not_authorized}
    end
  end
end
