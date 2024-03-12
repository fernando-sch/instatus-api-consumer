defmodule ShipayInstatus.IncidentsTest do
  use ShipayInstatus.DataCase, async: true

  alias ShipayInstatus.Incidents
  alias ShipayInstatus.Factory

  describe "create_incident/1" do
    test "returns the incident created" do
      attrs = Factory.params_for(:incident)
      assert {:ok, incident} = Incidents.create_incident(attrs)
      assert incident.id == attrs.id
    end

    test "returns error for missing required attrs" do
      assert {:error, changeset} = Incidents.create_incident(%{})

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
