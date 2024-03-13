defmodule InstatusWeb.Router do
  use InstatusWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/api", InstatusWeb do
    pipe_through :api
  end
end
