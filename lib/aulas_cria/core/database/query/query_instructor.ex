defmodule AulasCria.Core.Database.Query.QueryInstructor do
  @moduledoc """
    documentação desse modulo aqui InstructorUser
  """

  alias AulasCria.Core.DataBase.Model.InstructorUser
  alias AulasCria.Core.SdkAws
  alias AulasCria.Core.Database.Query.Helper

  @table_name "instructor"

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

  def create(params_instructor) do
    params_instructor =
      if is_struct(params_instructor),
        do: Map.from_struct(params_instructor),
        else: params_instructor

    SdkAws.call({:create, @table_name, params_instructor})
  end

  defp formater_instructor_user(%{"Count" => 0}), do: nil

  defp formater_instructor_user(%{"Items" => items}) do
    items
    |> List.wrap()
    |> Enum.map(fn item ->
      item = Helper.formater_result(item)

      %InstructorUser{
        about_me: item["about me"],
        background: item["background"],
        birthday: item["birthday"],
        email: item["email"],
        id: item["id"],
        name: item["name"],
        password: item["senha"],
        picture: item["foto"],
        schooling: item["schooling"],
        students: item["students"],
        tasks: item["tasks"],
        work_school: item["work school"]
      }
    end)
  end

  defp formater_instructor_user(%{"Item" => items}),
    do: formater_instructor_user(%{"Items" => items})
end
