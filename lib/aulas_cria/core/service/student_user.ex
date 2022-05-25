defmodule AulasCria.Core.Service.StudentUser do
  @moduledoc """
    documentação desse modulo aqui StudentUser
  """

  alias AulasCria.Core.Database.Query.QueryStudent
  alias AulasCria.Core.Authentication.Authentication
  alias AulasCria.Core.DataBase.Model.StudentUser
  alias AulasCria.Core.DataBase.Model.InstructorUser

  @spec get_all(StudentUser.t() | InstructorUser.t()) ::
          {:ok, list(StudentUser.t())} | {:error, :not_authorized}
  def get_all(requester) do
    case Authentication.authenticate(requester, nil) do
      true -> {:ok, QueryStudent.get_all()}
      false -> {:error, :not_authorized}
    end
  end

  def get_by(requester, opts_search) do
    case Authentication.authenticate(requester, nil) do
      true -> {:ok, QueryStudent.get_by(opts_search)}
      false -> {:error, :not_authorized}
    end
  end

  def get_per_instructor(requester, instructor_id) do
    case Authentication.authenticate(requester, nil) do
      true -> {:ok, QueryStudent.get_per_instructor(instructor_id)}
      false -> {:error, :not_authorized}
    end
  end

  def update(requester, student_user, update_student_user) do
    case Authentication.authenticate(requester, nil) do
      true -> {:ok, QueryStudent.update(student_user, update_student_user)}
      false -> {:error, :not_authorized}
    end
  end

  def delete(requester, student_user) do
    case Authentication.authenticate(requester, nil) do
      true -> {:ok, QueryStudent.delete(student_user)}
      false -> {:error, :not_authorized}
    end
  end

  def create(requester, _params_student_user) do
    case Authentication.authenticate(requester, nil) do
      true -> {:ok, QueryStudent.create(params_student_user)}
      false -> {:error, :not_authorized}
    end
  end
end
