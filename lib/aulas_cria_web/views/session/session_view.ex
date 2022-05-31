defmodule AulasCriaWeb.SessionView do
  use AulasCriaWeb, :view

  def normalize(string) do
    string
    |> to_string()
    |> String.replace("_", " ", [])
    |> String.capitalize()
  end

  defp inverse_type(:student), do: :instructor
  defp inverse_type(:instructor), do: :student
end
