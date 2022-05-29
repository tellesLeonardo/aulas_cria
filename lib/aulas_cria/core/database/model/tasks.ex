defmodule AulasCria.Core.DataBase.Model.Tasks do
  @moduledoc """
    documentação desse modulo aqui StudentUser
  """

  defstruct title: nil,
            description: nil,
            instructor: nil,
            category: nil,
            id: nil,
            created_at: nil,
            tags: [],
            amount_of_completion: 0,
            difficulty: 0,
            number_of_students: 0,
            tasks_videos: []
end
