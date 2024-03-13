defmodule InstatusAPIConsumerWeb.Webhooks.ControllerTest do
  use InstatusAPIConsumerWeb.ConnCase, async: true

  alias InstatusAPIConsumer.Factory

  describe "incident_notification/2" do
    test "returns 204" do
      payload = Factory.build(:incident_webhook_payload)
      conn = post(conn, Routes.airtable_path(conn, :incident_notification), payload)
      assert Repo.exists?(Incident, payload["incident"]["id"])
      assert response(conn, 204) == ""
    end
  end
end
