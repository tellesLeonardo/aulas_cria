defmodule AulasCria.Core.DataBase.Model.Tasks do
  @moduledoc """
    documentação desse modulo aqui StudentUser
  """

  defstruct title: nil,
            description: nil,
            dificuldade: nil,
            instructor: nil,
            category: nil,
            id: nil,
            created_at: nil,
            tags: []
end
