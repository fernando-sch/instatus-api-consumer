defmodule InstatusAPIConsumerWeb.Webhooks.NotificationController do
  use InstatusAPIConsumerWeb, :controller

  require Logger

  action_fallback InstatusAPIConsumerWeb.FallbackController

  alias InstatusAPIConsumer.Incidents

  # Incident notification
  def notification(conn, %{"incident" => incident_params}) do
    Logger.info("Incident notification:")
    IO.inspect(incident_params)

    with {:ok, _} <- Incidents.create_or_update_incident(incident_params) do
      send_resp(conn, :no_content, "")
    end
  end

  # Maintenance notification
  def notification(conn, %{"maintenance" => maintenance_params}) do
    Logger.info("Maintenance notification:")
    IO.inspect(maintenance_params)

    send_resp(conn, :no_content, "")
  end

  # Component notification
  def notification(conn, %{
        "component_update" => component_update_params,
        "component" => component_params
      }) do
    Logger.info("Component update notification:")
    IO.inspect(component_update_params)
    Logger.info("Component notification:")
    IO.inspect(component_params)

    send_resp(conn, :no_content, "")
  end
end
