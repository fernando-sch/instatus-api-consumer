defmodule InstatusAPIConsumerWeb.Webhooks.IncidentController do
  use InstatusAPIConsumerWeb, :controller

  action_fallback InstatusAPIConsumerWeb.FallbackController

  alias InstatusAPIConsumer.Incidents

  def incident(conn, %{"incident" => incident_params}) do
    IO.inspect incident_params
    with {:ok, _} <- Incidents.create_or_update_incident(incident_params) do
      send_resp(conn, :no_content, "")
    end
  end

  # TODO: don't return error on payload with maintenance or component update
  def incident(_, params) do
    IO.inspect params
    {:error, :bad_request}
  end
end