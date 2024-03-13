defmodule InstatusAPIConsumerWeb.Router do
  use InstatusAPIConsumerWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/api", InstatusAPIConsumerWeb do
    pipe_through :api
  end
end
