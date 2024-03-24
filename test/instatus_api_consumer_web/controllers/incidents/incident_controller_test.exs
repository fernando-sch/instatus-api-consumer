defmodule InstatusAPIConsumerWeb.Incidents.IncidentControllerTest do
  use InstatusAPIConsumerWeb.ConnCase, async: true

  alias InstatusAPIConsumer.Factory

  describe "index/2" do
    test "returns 200 listing all incidents" do
      incidents = Factory.insert_list(4, :incident)
      conn = get(build_conn(), "/api/incidents")
      body = json_response(conn, 200)
      assert body["data"] == build_index_body(incidents)
    end
  end

  ## Helpers

  defp build_index_body(incidents) do
    Enum.map(incidents, &build_show_body/1)
  end

  defp build_show_body(incident) do
    %{
      "impact" => incident.impact,
      "name" => incident.name,
      "status" => incident.status,
      "url" => incident.url,
      "resolved_at" => NaiveDateTime.to_iso8601(incident.resolved_at),
      "updated_at" => NaiveDateTime.to_iso8601(incident.updated_at),
      "created_at" => NaiveDateTime.to_iso8601(incident.created_at),
      "incident_updates" => build_incident_updates(incident)
    }
  end

  defp build_incident_updates(%{incident_updates: incident_updates}) do
    Enum.map(incident_updates, fn incident_update ->
      %{
        "body" => incident_update.body,
        "status" => incident_update.status,
        "markdown" => incident_update.markdown
      }
    end)
  end
end
