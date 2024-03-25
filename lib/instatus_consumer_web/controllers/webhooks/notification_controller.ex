defmodule InstatusConsumerWeb.Webhooks.NotificationController do
  use InstatusConsumerWeb, :controller

  require Logger

  action_fallback InstatusConsumerWeb.FallbackController

  alias InstatusConsumer.Incidents.CreateIncidentWorker

  # Incident notification
  def notification(conn, %{"incident" => incident_params}) do
    Logger.info("Incident notification:")
    IO.inspect(incident_params)

    CreateIncidentWorker.enqueue(incident_params)

    send_resp(conn, :no_content, "")
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
