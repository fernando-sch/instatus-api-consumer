defmodule InstatusAPIConsumer.Incidents.CreateIncidentWorkerTest do
  use InstatusAPIConsumer.DataCase, async: true

  alias InstatusAPIConsumer.Factory
  alias InstatusAPIConsumer.Incidents.CreateIncidentWorker

  describe "enqueue/1" do
    test "inserts a new oban job" do
      args = Factory.params_for(:incident)
      assert {:ok, %Oban.Job{}} = CreateIncidentWorker.enqueue(args)

      assert_enqueued(worker: CreateIncidentWorker, args: args, queue: :default)
    end
  end

  describe "perform/2" do
    test "creates a new incident" do
      args = Factory.params_for(:incident)

      assert {:ok, incident} = perform_job(CreateIncidentWorker, args)
      assert incident.name == args.name
      assert incident.impact == args.impact
    end

    test "returns error on incident creation" do
      assert {:error, changeset} = perform_job(CreateIncidentWorker, %{})

      assert errors_on(changeset) == %{
               created_at: ["can't be blank"],
               id: ["can't be blank"],
               name: ["can't be blank"],
               status: ["can't be blank"],
               updated_at: ["can't be blank"],
               url: ["can't be blank"]
             }
    end
  end
end
