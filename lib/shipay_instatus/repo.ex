defmodule InstatusAPIConsumer.Repo do
  use Ecto.Repo,
    otp_app: :instatus_api_consumer,
    adapter: Ecto.Adapters.Postgres
end
