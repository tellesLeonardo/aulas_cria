defmodule AulasCria.Core.Database.Query.QueryStudent do
  @moduledoc """
    documentação desse modulo aqui InstructorUser
  """

  alias AulasCria.Core.DataBase.Model.StudentUser
  alias AulasCria.Core.SdkAws
  alias AulasCria.Core.Database.Query.Helper

  @table_name "student"

  def get_all() do
    SdkAws.call({:all, @table_name})
    |> formater_instructor_user()
  end

  def get_by_id(instructor_id) do
    SdkAws.call({:get, @table_name, [id: instructor_id]})
    |> formater_instructor_user()
  end

  def get_per_instructor(_instructor_id) do
  end

  def update(instructor_id, update_instructor_user) do
    SdkAws.call({:update, @table_name, instructor_id, update_instructor_user})
  end

  def delete(instructor_id) do
    SdkAws.call({:delete, @table_name, [id: instructor_id]})
  end

  def create(params_user) do
    params_user =
      if is_struct(params_user),
        do: Map.from_struct(params_user),
        else: params_user

    SdkAws.call({:create, @table_name, params_user})
  end

  defp formater_instructor_user(%{"Count" => 0}), do: nil

  defp formater_instructor_user(%{"Items" => items}) do
    items
    |> List.wrap()
    |> Enum.map(fn item ->
      item = Helper.formater_result(item)

      %StudentUser{
        about_me: item["about me"],
        background: item["background"],
        birthday: item["birthday"],
        email: item["email"],
        id: item["id"],
        name: item["name"],
        password: item["password"],
        picture: item["foto"],
        school: item["school"],
        tasks: item["tasks"],
        colege: item["colege"],
        high_school: item["high_school"],
        instructors: item["instructors"]
      }
    end)
  end

  defp formater_instructor_user(%{"Item" => items}),
    do: formater_instructor_user(%{"Items" => items}) |> List.first()

  defp formater_instructor_user(_), do: nil
end
