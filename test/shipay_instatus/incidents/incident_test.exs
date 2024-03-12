defmodule ShipayInstatus.Incidents.IncidentTest do
  use ShipayInstatus.DataCase, async: true

  alias ShipayInstatus.Factory
  alias ShipayInstatus.Incidents.Incident

  describe "changeset/2" do
    test "validates required fields" do
      changeset = Incident.changeset(%Incident{}, %{})

      refute changeset.valid?

      assert errors_on(changeset) == %{
               id: ["can't be blank"],
               name: ["can't be blank"],
               status: ["can't be blank"],
               url: ["can't be blank"],
               created_at: ["can't be blank"],
               updated_at: ["can't be blank"]
             }
    end

    test "returns valid changeset" do
      attrs = Factory.params_for(:incident)
      attrs = Map.delete(attrs, :incident_updates)
      changeset = Incident.changeset(%Incident{}, attrs)

      assert changeset.valid?
      assert changeset.changes.id == attrs.id
      assert changeset.changes.name == attrs.name
      assert changeset.changes.status == attrs.status
    end
  end
end
