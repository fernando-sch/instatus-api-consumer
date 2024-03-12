defmodule ShipayInstatus.Incidents do
  @moduledoc false
  alias ShipayInstatus.Incidents.Incident
  alias ShipayInstatus.Repo

  @spec create_or_update_incident(map()) :: {:ok, Incident.t()} | {:error, Ecto.Changeset.t()}
  def create_or_update_incident(%{} = attrs) do
    incident_id = Map.get(attrs, :id, "") || Map.get(attrs, "id", "")

    case Repo.get(Incident, incident_id) do
      nil -> %Incident{}
      incident -> incident
    end
    |> Incident.changeset(attrs)
    |> Repo.insert_or_update()
  end
end
