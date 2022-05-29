defmodule AulasCria.Core.DataBase.Model.InstructorUser do
  @moduledoc """
    documentação desse modulo aqui InstructorUser
  """

  defstruct name: nil,
            id: nil,
            password: nil,
            birthday: nil,
            email: nil,
            schooling: nil,
            about_me: nil,
            picture: nil,
            background: nil,
            students: [],
            tasks: [],
            work_school: nil
end
