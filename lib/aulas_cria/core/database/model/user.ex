defmodule AulasCria.Core.DataBase.Model.User do
  @moduledoc """
    documentação desse modulo aqui StudentUser

  """

  use Ecto.Schema
  import Ecto.Changeset
  alias Comeonin.Bcrypt

  @primary_key {:id, :binary_id, autogenerate: true}

  @field ~w(name password birthday email school about_me picture background)

  schema "user" do
    field(:name, :string, virtual: true)
    field(:password, :string, virtual: true)
    field(:birthday, :time, virtual: true)
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
    |> unique_constraint([:username, :password])
    |> validate_required([:username, :password])
    |> update_change(:password, &Bcrypt.hashpwsalt/1)
  end

  def change_user(%__MODULE__{} = user) do
    Ecto.Changeset.change(user)
  end
end
