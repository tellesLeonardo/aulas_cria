defmodule AulasCria.Core.Service.StudentUser do
  @moduledoc """
    documentação desse modulo aqui StudentUser
  """

  alias AulasCria.Core.Database.Query.QueryStudent
  alias AulasCria.Core.Authentication.Authentication

  def get_all(requester) do
    case Authentication.authenticate(requester) do
      true -> {:ok, QueryStudent.get_all()}
      false -> {:error, :not_authorized}
    end
  end

  def get_by_id(requester, instructor_id) do
    case Authentication.authenticate(requester) do
      true -> {:ok, QueryStudent.get_by_id(instructor_id)}
      false -> {:error, :not_authorized}
    end
  end

  def get_per_instructor(requester, instructor_id) do
    case Authentication.authenticate(requester) do
      true -> {:ok, QueryStudent.get_per_instructor(instructor_id)}
      false -> {:error, :not_authorized}
    end
  end

  def update(requester, instructor_id, update_student_user) do
    case Authentication.authenticate(requester) do
      true -> {:ok, QueryStudent.update(instructor_id, update_student_user)}
      false -> {:error, :not_authorized}
    end
  end

  def delete(requester, student_user) do
    case Authentication.authenticate(requester) do
      true -> {:ok, QueryStudent.delete(student_user.id)}
      false -> {:error, :not_authorized}
    end
  end

  def create(requester, params_student_user) do
    case Authentication.authenticate(requester) do
      true -> {:ok, QueryStudent.create(params_student_user)}
      false -> {:error, :not_authorized}
    end
  end
end
