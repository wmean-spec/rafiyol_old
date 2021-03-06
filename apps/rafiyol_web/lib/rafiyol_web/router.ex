defmodule RafiyolWeb.Router do
  use RafiyolWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
    plug RafiyolWeb.Authenticator
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", RafiyolWeb do
    pipe_through :browser

    get "/", PageController, :index

    resources "/words", WordController

    resources "/users", UserController, only: [:show, :new, :create, :update]


    get "/login", SessionController, :new
    post "/login", SessionController, :create
    delete "/logout", SessionController, :delete

    scope "/learn" do
      get "/", LearnController, :show
      post "/start", LearnController, :create
      get "/session", LearnController, :edit
      post "/session", LearnController, :update
      get "/session/finish", LearnController, :delete
    end
  end

  # Other scopes may use custom stacks.
  # scope "/api", RafiyolWeb do
  #   pipe_through :api
  # end

  # Enables LiveDashboard only for development
  #
  # If you want to use the LiveDashboard in production, you should put
  # it behind authentication and allow only admins to access it.
  # If your application does not have an admins-only section yet,
  # you can use Plug.BasicAuth to set up some basic authentication
  # as long as you are also using SSL (which you should anyway).
  if Mix.env() in [:dev, :test] do
    import Phoenix.LiveDashboard.Router

    scope "/" do
      pipe_through :browser
      live_dashboard "/dashboard", metrics: RafiyolWeb.Telemetry
    end
  end
end
