defmodule AulasCria.Core.SdkAws.Clients.Client do
  @moduledoc false

  import AWS.Client

  @access_key_id Application.get_env(:aulas_cria, :aws)[:access_key_id]
  @secret_access_key Application.get_env(:aulas_cria, :aws)[:secret_access_key]
  @region Application.get_env(:aulas_cria, :aws)[:region]

  def create_or_acess() do
    create(
      @access_key_id,
      @secret_access_key,
      @region
    )
  end
end
