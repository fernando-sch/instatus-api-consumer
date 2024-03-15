defmodule InstatusAPIConsumerWeb.Webhooks.NotificationControllerTest do
  use InstatusAPIConsumerWeb.ConnCase, async: true

  alias InstatusAPIConsumer.Repo
  alias InstatusAPIConsumer.Factory
  alias InstatusAPIConsumer.Incidents.Incident

  describe "notification/2" do
    test "returns 204 no content" do
      payload = Factory.build(:incident_webhook_payload)
      conn = post(build_conn(), "/api/webhooks/notification", payload)
      assert Repo.exists?(Incident, id: payload["incident"]["id"])
      assert response(conn, 204) == ""
    end

    test "returns 400 bad request" do
      conn = post(build_conn(), "/api/webhooks/notification", %{})
      assert json_response(conn, 400) == %{"errors" => %{"detail" => "Bad Request"}}
    end
  end
end
