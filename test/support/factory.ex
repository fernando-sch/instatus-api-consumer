defmodule InstatusAPIConsumer.Factory do
  @moduledoc """
    Factory of fixtures using ex-machina lib, for tests
  """
  use ExMachina.Ecto, repo: InstatusAPIConsumer.Repo

  alias InstatusAPIConsumer.Incidents.Incident

  def incident_factory do
    stringified_utc_now = NaiveDateTime.utc_now() |> NaiveDateTime.to_string()

    %Incident{
      id: sequence("id_"),
      impact: sequence("impact_"),
      name: sequence("name_"),
      status: get_incident_status(),
      url: sequence("https://some_url_"),
      resolved_at: stringified_utc_now,
      updated_at: stringified_utc_now,
      created_at: stringified_utc_now,
      incident_updates: build_list(2, :incident_update)
    }
  end

  def incident_update_factory do
    stringified_utc_now = NaiveDateTime.utc_now() |> NaiveDateTime.to_string()

    %Incident.Update{
      incident_id: sequence("id_"),
      body: sequence("body_"),
      status: get_incident_status(),
      created_at: stringified_utc_now,
      updated_at: stringified_utc_now
    }
  end

  defp get_incident_status,
    do: Enum.random(["INVESTIGATING", "IDENTIFIED", "MONITORING", "RESOLVED"])

  def incident_webhook_payload do
    stringified_utc_now = NaiveDateTime.utc_now() |> NaiveDateTime.to_string()

    %{
      "meta" => %{
        "unsubscribe" => sequence("https://unsub_"),
        "documentation" => "https://docs_",
      },
      "page" => %{
        "id" => sequence("page_id_"),
        "status_indicator" => sequence("indicator_"),
        "status_description" => sequence("description_"),
        "url" => sequence("https://page_url_")
      },
      "incident" => %{
        "id" => sequence("incident_id_"),
        "name" => sequence("name_"),
        "impact" => sequence("impact_"),
        "status" => get_incident_status(),
        "url" => sequence("https://incident_url_"),
        "backfilled" => false,
        "created_at" => stringified_utc_now,
        "resolved_at" => stringified_utc_now,
        "updated_at" => stringified_utc_now,
        "incident_updates" => [%{
          "id" => sequence("incident_update_id_"),
          "incident_id" => sequence("incident_id_"),
          "body" => sequence("body_"),
          "status" => get_incident_status(),
          "created_at" => stringified_utc_now,
          "updated_at" => stringified_utc_now,
        }],
      },
    }
  end
end
