defmodule AulasCria.Core.DataBase.Model.User do
  @moduledoc """
    documentação desse modulo aqui StudentUser

  """

  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}

  @field ~w(name username password birthday email school about_me picture background)a
  @required ~w(name username birthday email school)a

  schema "user" do
    field(:name, :string, virtual: true)
    field(:username, :string, virtual: true)
    field(:password, :string, virtual: true)
    field(:birthday, :date, virtual: true)
    field(:email, :string, virtual: true)
    field(:school, :string, virtual: true)
    field(:about_me, :string, virtual: true)
    field(:picture, :string, virtual: true)
    field(:background, :string, virtual: true)
    timestamps(virtual: true)
  end

  def changeset(%__MODULE__{} = user, params) do
    user
    |> cast(params, @field)
    |> validate_required(@required)
    |> unique_constraint([:username, :password])
  end

  def change_user(%__MODULE__{} = user) do
    Ecto.Changeset.change(user)
  end

  def change_user(), do: change_user(%__MODULE__{})
end
