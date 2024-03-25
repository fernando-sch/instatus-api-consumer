defmodule InstatusConsumerWeb.Incidents.IncidentController do
  use InstatusConsumerWeb, :controller

  action_fallback InstatusConsumerWeb.FallbackController

  alias InstatusConsumer.Incidents

  def index(conn, _) do
    incidents = Incidents.list_incidents()

    render(conn, :index, incidents: incidents)
  end
end
