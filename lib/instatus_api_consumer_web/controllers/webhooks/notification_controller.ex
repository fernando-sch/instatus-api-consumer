defmodule InstatusAPIConsumerWeb.Webhooks.NotificationController do
  use InstatusAPIConsumerWeb, :controller

  action_fallback InstatusAPIConsumerWeb.FallbackController

  alias InstatusAPIConsumer.Incidents

  # Incident notification
  def notification(conn, %{"incident" => incident_params}) do
    IO.inspect("Incident notification: #{incident_params}")
    with {:ok, _} <- Incidents.create_or_update_incident(incident_params) do
      send_resp(conn, :no_content, "")
    end
  end

  # Maintenance notification
  def notification(conn, %{"maintenance" => maintenance_params}) do
    IO.inspect("Maintenance notification: #{maintenance_params}")

    send_resp(conn, :no_content, "")
  end

  # Component notification
  def notification(conn, %{"component_update" => component_update_params, "component" => component_params}) do
    IO.inspect("Component update notification: #{component_update_params}")
    IO.inspect("Component notification: #{component_params}")

    send_resp(conn, :no_content, "")
  end
end
