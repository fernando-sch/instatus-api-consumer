defmodule ShipayInstatus.Repo.Migrations.AddIncidentsTable do
  use Ecto.Migration

  def change do
    create table(:incidents, primary_key: false) do
      add(:id, :string, primary_key: true, null: false)
      add(:impact, :string)
      add(:name, :string)
      add(:status, :string)
      add(:url, :string)
      add(:incident_updates, {:array, :jsonb}, default: [])
      add(:resolved_at, :naive_datetime_usec)
      add(:updated_at, :naive_datetime_usec)
      add(:created_at, :naive_datetime_usec)
    end
  end
end
