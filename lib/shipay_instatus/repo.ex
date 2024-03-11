defmodule ShipayInstatus.Repo do
  use Ecto.Repo,
    otp_app: :shipay_instatus,
    adapter: Ecto.Adapters.Postgres
end
