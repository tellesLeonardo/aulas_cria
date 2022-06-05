defmodule AulasCriaWeb.CadastroView do
  use AulasCriaWeb, :view

  def dias do
    Enum.to_list(1..31)
  end

  def meses do
    [
      janeiro: 1,
      fevereiro: 2,
      março: 3,
      abril: 4,
      maio: 5,
      junho: 6,
      julho: 7,
      agosto: 8,
      setembro: 9,
      outubro: 10,
      novembro: 11,
      dezembro: 12
    ]
  end

  def anos do
    Enum.to_list(2022..1950)
  end
end
