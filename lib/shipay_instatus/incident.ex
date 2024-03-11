defmodule ShipayInstatus.Incident do
  @moduledoc false
  use Ecto.Schema

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
      field(:created_at, :utc_datetime)
      field(:updated_at, :utc_datetime)
    end
  end
end
