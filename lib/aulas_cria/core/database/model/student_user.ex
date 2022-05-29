defmodule AulasCria.Core.DataBase.Model.StudentUser do
  @moduledoc """
    documentação desse modulo aqui StudentUser
  """

  defstruct name: nil,
            id: nil,
            password: nil,
            birthday: nil,
            email: nil,
            school: nil,
            about_me: nil,
            picture: nil,
            background: nil,
            colege: false,
            high_school: false,
            instructors: [],
            tasks: []
end
