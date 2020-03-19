defmodule MindTheGappWeb.Router do
  use MindTheGappWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
    plug CORSPlug, origin: System.get_env("CORS_ALLOWED_ENDPOINT")
  end

  scope "/", MindTheGappWeb do
    pipe_through :api

    get "/", ArrivalTimeController, :index
  end

  # Other scopes may use custom stacks.
  # scope "/api", MindTheGappWeb do
  #   pipe_through :api
  # end
end
