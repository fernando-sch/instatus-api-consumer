defmodule InstatusConsumerWeb.Router do
  use InstatusConsumerWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/api", InstatusConsumerWeb do
    pipe_through :api

    scope("/webhooks", Webhooks, as: :webhooks) do
      post("/notification", NotificationController, :notification)
    end

    resources("/incidents", Incidents.IncidentController, only: [:index])
  end
end
