defmodule ShipayInstatus.IncidentsTest do
  use ShipayInstatus.DataCase, async: true

  alias ShipayInstatus.Incidents
  alias ShipayInstatus.Factory

  describe "create_or_update_incident/1" do
    test "creates an incident" do
      attrs = Factory.params_for(:incident)
      assert {:ok, incident} = Incidents.create_or_update_incident(attrs)
      assert incident.id == attrs.id
    end

    test "updates an incident" do
      incident = Factory.insert(:incident, status: "IDENTIFIED", incident_updates: [])
      incident_update = Factory.params_for(:incident_update, status: "RESOLVED")
      attrs = %{id: incident.id, status: "RESOLVED", incident_updates: [incident_update]}
      assert {:ok, incident} = Incidents.create_or_update_incident(attrs)
      assert incident.status == attrs.status
      assert length(incident.incident_updates) == 1
    end

    test "returns error for missing required attrs" do
      assert {:error, changeset} = Incidents.create_or_update_incident(%{})

      assert errors_on(changeset) == %{
               id: ["can't be blank"],
               name: ["can't be blank"],
               status: ["can't be blank"],
               url: ["can't be blank"],
               created_at: ["can't be blank"],
               updated_at: ["can't be blank"]
             }
    end
  end
end
