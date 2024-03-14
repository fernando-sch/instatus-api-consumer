defmodule InstatusAPIConsumerWeb.Webhooks.IncidentControllerTest do
  use InstatusAPIConsumerWeb.ConnCase, async: true

  alias InstatusAPIConsumer.Repo
  alias InstatusAPIConsumer.Factory
  alias InstatusAPIConsumer.Incidents.Incident

  describe "incident/2" do
    test "returns 204 no content" do
      payload = Factory.build(:incident_webhook_payload)
      conn = post(build_conn(), "/api/webhooks/incidents", payload)
      assert Repo.exists?(Incident, id: payload["incident"]["id"])
      assert response(conn, 204) == ""
    end

    test "returns 400 bad request" do
      conn = post(build_conn(), "/api/webhooks/incidents", %{})
      assert json_response(conn, 400) == %{"errors" => %{"detail" => "Bad Request"}}
    end
  end
end
