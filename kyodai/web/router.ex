defmodule Kyodai.Router do
  use Kyodai.Web, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
    plug Kyodai.Auth, repo: Kyodai.Repo
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", Kyodai do
    pipe_through :browser # Use the default browser stack

    get "/", PageController, :index
    resources "/users", UserController, only: [:index, :show, :new, :create]
    resources "/sessions", SessionController, only: [:new, :create, :delete]
  
  end

  # Other scopes may use custom stacks.
  # scope "/api", Kyodai do
  #   pipe_through :api
  # end
end
