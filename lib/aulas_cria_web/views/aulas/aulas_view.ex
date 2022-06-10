defmodule AulasCriaWeb.AulasView do
  use AulasCriaWeb, :view

  alias AulasCriaWeb.Live.Aulas.Interests
  alias AulasCriaWeb.Router.Helpers, as: Routes

  def get_image(true, socket) do
    Routes.static_path(socket, "/images/avatar.jpg")
  end

  def get_image(picture, _socket), do: picture

  def count_att(tasks) do
    tasks
    |> Enum.filter(& &1["finish"])
    |> length()
  end

  def count_pts(tasks) do
    tasks
    |> Enum.filter(& &1["finish"])
    |> Enum.reduce(0, fn x, acc -> acc + get_points(x["difficulty"]) end)
  end

  defp get_points(nil), do: 0

  defp get_points(point) do
    {float, _} =
      point
      |> to_string()
      |> Float.parse()
      |> ceil()

    float
  end
end
