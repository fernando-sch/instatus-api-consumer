defmodule InstatusAPIConsumer.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      InstatusAPIConsumerWeb.Telemetry,
      InstatusAPIConsumer.Repo,
      {DNSCluster,
       query: Application.get_env(:instatus_api_consumer, :dns_cluster_query) || :ignore},
      {Phoenix.PubSub, name: InstatusAPIConsumer.PubSub},
      # Start a worker by calling: InstatusAPIConsumer.Worker.start_link(arg)
      # {InstatusAPIConsumer.Worker, arg},
      # Start to serve requests, typically the last entry
      InstatusAPIConsumerWeb.Endpoint
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: InstatusAPIConsumer.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    InstatusAPIConsumerWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
