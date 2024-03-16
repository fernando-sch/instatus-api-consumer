defmodule InstatusAPIConsumer.Incidents.IncidentTest do
  use InstatusAPIConsumer.DataCase, async: true

  alias InstatusAPIConsumer.Factory
  alias InstatusAPIConsumer.Incidents.Incident

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
      changeset = Incident.changeset(%Incident{}, attrs)

      assert changeset.valid?
      assert changeset.changes.id == attrs.id
      assert changeset.changes.name == attrs.name
      assert changeset.changes.status == attrs.status
      assert length(changeset.changes.incident_updates) == 2
    end
  end
end
