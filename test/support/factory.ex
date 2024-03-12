defmodule ShipayInstatus.Factory do
  @moduledoc """
    Factory of fixtures using ex-machina lib, for tests
  """
  use ExMachina.Ecto, repo: ToDo.Repo

  alias ShipayInstatus.Incident

  def incident_factory do
    stringified_utc_now = NaiveDateTime.utc_now() |> NaiveDateTime.to_string()

    %Incident{
      id: sequence("id_"),
      impact: sequence("impact_"),
      name: sequence("name_"),
      status: get_incident_status(),
      url: sequence("https://some_url_"),
      resolved_at: stringified_utc_now,
      updated_at: stringified_utc_now,
      created_at: stringified_utc_now,
      incident_updates: build_list(2, :incident_update)
    }
  end

  def incident_update_factory do
    stringified_utc_now = NaiveDateTime.utc_now() |> NaiveDateTime.to_string()

    %Incident.Update{
      incident_id: sequence("id_"),
      body: sequence("body_"),
      status: get_incident_status(),
      created_at: stringified_utc_now,
      updated_at: stringified_utc_now
    }
  end

  defp get_incident_status,
    do: Enum.random(["INVESTIGATING", "IDENTIFIED", "MONITORING", "RESOLVED"])
end
