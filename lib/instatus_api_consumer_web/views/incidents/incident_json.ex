defmodule InstatusConsumerWeb.Incidents.IncidentJSON do
  alias InstatusConsumer.Incidents.Incident
  alias InstatusConsumerWeb.Incidents.IncidentUpdateJSON

  def index(%{incidents: incidents}) do
    %{data: for(incident <- incidents, do: data(incident))}
  end

  def show(%{incident: incident}) do
    %{data: data(incident)}
  end

  def data(%Incident{incident_updates: incident_updates} = incident) do
    incident_updates =
      for(incident_update <- incident_updates, do: IncidentUpdateJSON.data(incident_update))

    %{
      impact: incident.impact,
      name: incident.name,
      status: incident.status,
      url: incident.url,
      resolved_at: incident.resolved_at,
      updated_at: incident.updated_at,
      created_at: incident.created_at,
      incident_updates: incident_updates
    }
  end
end
