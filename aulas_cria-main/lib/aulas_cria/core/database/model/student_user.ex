defmodule AulasCria.Core.DataBase.Model.StudentUser do
  @moduledoc """
    documentação desse modulo aqui StudentUser
  """

  defstruct name: nil,
            id: nil,
            password: nil,
            birth_date: nil,
            email: nil,
            schooling: nil,
            educational_institution: nil,
            about_me: nil,
            picture: nil,
            background_picture: nil
end
