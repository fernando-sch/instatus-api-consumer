defmodule InstatusConsumer.Repo do
  use Ecto.Repo,
    otp_app: :instatus_consumer,
    adapter: Ecto.Adapters.Postgres
end
