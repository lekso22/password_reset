defmodule PasswordReset.Router do
  use PasswordReset.Web, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", PasswordReset do
    pipe_through :browser # Use the default browser stack
    get "/", UserController, :index
    get "/forgot", UserController, :forgot
    post "/forgot", UserController, :create
    get "/forgot/reset/:token", UserController, :update
    patch "/forgot/reset/:token", UserController, :recover
  end

  # Other scopes may use custom stacks.
  # scope "/api", PasswordReset do
  #   pipe_through :api
  # end
end
