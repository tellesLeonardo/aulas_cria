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

  def find_badge(:student), do: "rounded-2xl		 bg-red-100 text-red-800 text-lg font-semibold mr-2 px-2.5 py-0.5 rounded dark:bg-red-200 dark:text-red-900"
  def find_badge(:instructor), do: "rounded-2xl	 bg-purple-100 text-purple-800 text-lg font-semibold mr-2 px-2.5 py-0.5 rounded dark:bg-purple-200 dark:text-purple-900"
end
