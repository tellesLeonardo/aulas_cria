defmodule AulasCriaWeb.Router do
  use AulasCriaWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_live_flash
    plug :put_root_layout, {AulasCriaWeb.LayoutView, :root}
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  pipeline :live_view do
    plug(:put_root_layout, {AulasCriaWeb.LayoutView, :live})
  end

  pipeline :authenticated do
    plug AulasCriaWeb.AuthHandler
  end

  # Other scopes may use custom stacks.
  # scope "/api", AulasCriaWeb do
  #   pipe_through :api
  # end

  # Enables LiveDashboard only for development
  #
  # If you want to use the LiveDashboard in production, you should put
  # it behind authentication and allow only admins to access it.
  # If your application does not have an admins-only section yet,
  # you can use Plug.BasicAuth to set up some basic authentication
  # as long as you are also using SSL (which you should anyway).

  import Phoenix.LiveDashboard.Router

  scope "/", AulasCriaWeb do
    pipe_through([:browser])

    live "/", Live.Node.Red
  end

  # scope "/login", AulasCriaWeb do
  #   pipe_through([:browser])

  #   get "/", SessionController, :index
  #   # get "/", SessionController, :new
  #   post "/sign-in", SessionController, :create
  #   get "/sign-up", SessionController, :new2
  #   post "/sign-up", SessionController, :create2
  #   get "/sign-out", SessionController, :delete
  # end

  # scope "/", AulasCriaWeb do
  #   pipe_through([:browser, :authenticated])

  #   resources "/", RegistrationController, only: [:index]

  #   live_dashboard "/dashboard", metrics: Telemetry
  # end

  # scope "/aulas", AulasCriaWeb do
  #   pipe_through([:browser, :live_view])

  #   live "/", Live.Aulas.AulasLive
  #   live "/task", Live.Tasks.TasksLive
  #   live "/cadastro", Live.Cadastro.CadastroLive
  # end
end
