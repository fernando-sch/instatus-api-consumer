defmodule InstatusAPIConsumer.Incidents do
  @moduledoc false
  alias InstatusAPIConsumer.Incidents.Incident
  alias InstatusAPIConsumer.Repo

  @spec create_or_update_incident(map()) :: {:ok, Incident.t()} | {:error, Ecto.Changeset.t()}
  def create_or_update_incident(%{} = attrs) do
    incident_id = attrs[:id] || attrs["id"] || ""

    case Repo.get(Incident, incident_id) do
      nil -> %Incident{}
      incident -> incident
    end
    |> Incident.changeset(attrs)
    |> Repo.insert_or_update()
  end
end
