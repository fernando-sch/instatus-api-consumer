defmodule InstatusAPIConsumerWeb.Incidents.IncidentUpdateJSON do
  alias InstatusAPIConsumer.Incidents.Incident

  def data(%Incident.Update{} = incident_update) do
    %{
      body: incident_update.body,
      status: incident_update.status,
      markdown: incident_update.markdown
    }
  end
end
