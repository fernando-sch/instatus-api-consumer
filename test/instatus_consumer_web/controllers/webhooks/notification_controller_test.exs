defmodule InstatusConsumerWeb.Webhooks.NotificationControllerTest do
  use InstatusConsumerWeb.ConnCase, async: true

  alias InstatusConsumer.Incidents.CreateIncidentWorker
  alias InstatusConsumer.Factory

  describe "notification/2" do
    test "returns 204 no content for incident notification" do
      payload = Factory.build(:incident_webhook_payload)
      conn = post(build_conn(), "/api/webhooks/notification", payload)
      assert_enqueued(worker: CreateIncidentWorker, args: payload["incident"])
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
