defmodule InstatusAPIConsumer.Incidents.Incident do
  @moduledoc false
  use Ecto.Schema
  import Ecto.Changeset

  @type t :: %__MODULE__{
          impact: String.t(),
          name: String.t(),
          status: String.t(),
          url: String.t(),
          resolved_at: NaiveDateTime.t(),
          updated_at: NaiveDateTime.t(),
          created_at: NaiveDateTime.t(),
          incident_updates: list(update())
        }

  @type update :: %__MODULE__.Update{
          incident_id: String.t(),
          body: String.t(),
          status: String.t(),
          created_at: DateTime.t(),
          updated_at: DateTime.t()
        }

  @primary_key {:id, :string, autogenerate: false}
  schema "incidents" do
    field(:impact, :string)
    field(:name, :string)
    field(:status, :string)
    field(:url, :string)
    field(:resolved_at, :naive_datetime_usec)
    field(:updated_at, :naive_datetime_usec)
    field(:created_at, :naive_datetime_usec)

    embeds_many(:incident_updates, Update, on_replace: :delete) do
      field(:incident_id, :string)
      field(:body, :string)
      field(:status, :string)
      field(:markdown, :string)
      field(:created_at, :utc_datetime)
      field(:updated_at, :utc_datetime)
    end
  end

  @spec changeset(t(), map()) :: Ecto.Changeset.t()
  def changeset(%__MODULE__{} = incident, %{} = attrs) do
    required_fields = [:id, :name, :status, :url, :created_at, :updated_at]
    optional_fields = [:impact, :resolved_at]

    incident
    |> cast(attrs, required_fields ++ optional_fields)
    |> validate_required(required_fields)
    |> cast_embed(:incident_updates, with: &incident_update_changeset/2, required: false)
  end

  def incident_update_changeset(%__MODULE__.Update{} = incident_update, %{} = attrs) do
    required_fields = [:incident_id, :status, :created_at, :updated_at]
    optional_fields = [:body, :markdown]

    incident_update
    |> cast(attrs, required_fields ++ optional_fields)
    |> validate_required(required_fields)
  end
end
