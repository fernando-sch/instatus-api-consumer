defmodule InstatusAPIConsumerWeb.Webhooks.NotificationControllerTest do
  use InstatusAPIConsumerWeb.ConnCase, async: true

  alias InstatusAPIConsumer.Repo
  alias InstatusAPIConsumer.Factory
  alias InstatusAPIConsumer.Incidents.Incident

  describe "notification/2" do
    test "returns 204 no content for incident notification" do
      payload = Factory.build(:incident_webhook_payload)
      conn = post(build_conn(), "/api/webhooks/notification", payload)
      assert Repo.exists?(Incident, id: payload["incident"]["id"])
      assert response(conn, 204) == ""
    end

    test "returns 204 no content for maintenance notification" do
      payload = Factory.build(:incident_webhook_payload)
      conn = post(build_conn(), "/api/webhooks/notification", payload)
      assert response(conn, 204) == ""
    end

    test "returns 204 no content for component notification" do
      payload = Factory.build(:incident_webhook_payload)
      conn = post(build_conn(), "/api/webhooks/notification", payload)
      assert response(conn, 204) == ""
    end
  end
end
