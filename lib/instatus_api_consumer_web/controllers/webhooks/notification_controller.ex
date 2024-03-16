defmodule InstatusAPIConsumerWeb.Webhooks.NotificationController do
  use InstatusAPIConsumerWeb, :controller

  require Logger

  action_fallback InstatusAPIConsumerWeb.FallbackController

  alias InstatusAPIConsumer.Incidents

  # Incident notification
  def notification(conn, %{"incident" => incident_params}) do
    Logger.info("Incident notification: #{incident_params}")
    with {:ok, _} <- Incidents.create_or_update_incident(incident_params) do
      send_resp(conn, :no_content, "")
    end
  end

  # Maintenance notification
  def notification(conn, %{"maintenance" => maintenance_params}) do
    Logger.info("Maintenance notification: #{maintenance_params}")

    send_resp(conn, :no_content, "")
  end

  # Component notification
  def notification(conn, %{"component_update" => component_update_params, "component" => component_params}) do
    Logger.info("Component update notification: #{component_update_params}")
    Logger.info("Component notification: #{component_params}")

    send_resp(conn, :no_content, "")
  end
end
