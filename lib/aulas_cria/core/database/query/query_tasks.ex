defmodule AulasCria.Core.Database.Query.QueryTasks do
  @moduledoc """
    documentação desse modulo aqui InstructorUser
  """

  alias AulasCria.Core.DataBase.Model.Tasks
  alias AulasCria.Core.SdkAws
  alias AulasCria.Core.Database.Query.Helper

  @table_name "tasks"

  def get_all() do
    SdkAws.call({:all, @table_name})
    |> formater_instructor_user()
  end

  def get_id_id(task_id) do
    SdkAws.call({:get, @table_name, [id: task_id]})
    |> formater_instructor_user()
  end

  def update(task_id, update_task) do
    SdkAws.call({:update, @table_name, task_id, update_task})
  end

  def delete(task_id) do
    SdkAws.call({:delete, @table_name, [id: task_id]})
  end

  def create(params_tasks) do
    params_tasks =
      if is_struct(params_tasks),
        do: Map.from_struct(params_tasks),
        else: params_tasks

    SdkAws.call({:create, @table_name, params_tasks})
  end

  defp formater_instructor_user(%{"Count" => 0}), do: nil

  defp formater_instructor_user(%{"Items" => items}) do
    items
    |> List.wrap()
    |> Enum.map(fn item ->
      item = Helper.formater_result(item)

      %Tasks{
        title: item["title"],
        description: item["description"],
        instructor: item["instructor"],
        category: item["category"],
        id: item["id"],
        created_at: item["created_at"],
        tags: item["tags"],
        amount_of_completion: item["amount_of_completion"],
        difficulty: item["difficulty"],
        number_of_students: item["number_of_students"],
        tasks_videos: item["tasks_videos"]
      }
    end)
  end

  defp formater_instructor_user(%{"Item" => items}),
    do: formater_instructor_user(%{"Items" => items}) |> List.first()

  defp formater_instructor_user(_), do: nil
end
