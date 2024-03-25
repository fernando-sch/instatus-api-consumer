defmodule InstatusConsumer.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    Oban.Telemetry.attach_default_logger()

    children = [
      InstatusConsumerWeb.Telemetry,
      InstatusConsumer.Repo,
      {DNSCluster,
       query: Application.get_env(:instatus_consumer, :dns_cluster_query) || :ignore},
      {Phoenix.PubSub, name: InstatusConsumer.PubSub},
      # Start a worker by calling: InstatusConsumer.Worker.start_link(arg)
      # {InstatusConsumer.Worker, arg},
      # Start to serve requests, typically the last entry
      InstatusConsumerWeb.Endpoint,
      {Oban, Application.fetch_env!(:instatus_consumer, Oban)}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: InstatusConsumer.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    InstatusConsumerWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
