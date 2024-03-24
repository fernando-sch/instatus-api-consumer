defmodule InstatusAPIConsumer.Incidents.CreateIncidentWorker do
  use Oban.Worker, queue: :default

  alias InstatusAPIConsumer.Incidents
  alias InstatusAPIConsumer.Incidents.Incident

  @spec enqueue(map()) :: {:ok, Oban.Job.t()} | {:error, Oban.Job.changeset() | term()}
  def enqueue(%{} = args) do
    args
    |> new()
    |> Oban.insert()
  end

  @impl Worker
  def perform(%Job{args: args}) do
    case Incidents.create_or_update_incident(args) do
      {:ok, %Incident{} = incident} -> {:ok, incident}
      {:error, reason} -> {:error, reason}
    end
  end
end
