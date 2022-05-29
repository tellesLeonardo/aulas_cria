defmodule AulasCria.Core.Authentication.Authentication do
  @moduledoc """
    documentação desse modulo aqui StudentUser
  """

  alias AulasCria.Core.DataBase.Model.{InstructorUser, StudentUser}

  require Logger

  def authenticate(%InstructorUser{} = instruct_user) do
    Logger.warn("Tentou fazer a autenticação #{inspect(instruct_user)}")

    true
  end

  def authenticate(%StudentUser{} = student_user) do
    Logger.warn("Tentou fazer a autenticação #{inspect(student_user)}")
    true
  end

  def authenticate(_), do: false
end
