defmodule InstatusAPIConsumerWeb.Incidents.IncidentController do
  use InstatusAPIConsumerWeb, :controller

  action_fallback InstatusAPIConsumerWeb.FallbackController

  alias InstatusAPIConsumer.Incidents

  def index(conn, _) do
    incidents = Incidents.list_incidents()

    render(conn, :index, incidents: incidents)
  end
end
