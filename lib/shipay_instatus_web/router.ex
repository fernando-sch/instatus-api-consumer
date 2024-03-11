defmodule ShipayInstatusWeb.Router do
  use ShipayInstatusWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/api", ShipayInstatusWeb do
    pipe_through :api
  end
end
