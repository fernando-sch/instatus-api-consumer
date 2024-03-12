defmodule ShipayInstatus.Incidents do
  @moduledoc false
  alias ShipayInstatus.Incidents.Incident
  alias ShipayInstatus.Repo

  @spec create_incident(map()) :: {:ok, Incident.t()} | {:error, Ecto.Changeset.t()}
  def create_incident(%{} = attrs) do
    %Incident{}
    |> Incident.changeset(attrs)
    |> Repo.insert()
  end
end
