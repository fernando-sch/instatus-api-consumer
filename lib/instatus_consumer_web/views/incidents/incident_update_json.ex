defmodule InstatusConsumerWeb.Incidents.IncidentUpdateJSON do
  alias InstatusConsumer.Incidents.Incident

  def data(%Incident.Update{} = incident_update) do
    %{
      body: incident_update.body,
      status: incident_update.status,
      markdown: incident_update.markdown
    }
  end
end
