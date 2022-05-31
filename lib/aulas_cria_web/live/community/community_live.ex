defmodule AulasCriaWeb.Live.Community.CommunityLive do
  use Phoenix.LiveView

  alias AulasCria.PubSub

  def render(assigns) do
    Phoenix.View.render(AulasCriaWeb.CommunityView, "community.html", assigns)
  end

  def mount(_params, _session, socket) do
    user = %{}
    {:ok, assign(socket, user: user)}
  end

end
