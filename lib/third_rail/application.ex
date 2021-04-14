defmodule ThirdRail.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  def start(_type, _args) do
    children = [
      # Start the Ecto repository
      ThirdRail.Repo,
      # Start the Telemetry supervisor
      ThirdRailWeb.Telemetry,
      # Start the PubSub system
      {Phoenix.PubSub, name: ThirdRail.PubSub},
      # Start the Endpoint (http/https)
      ThirdRailWeb.Endpoint
      # Start a worker by calling: ThirdRail.Worker.start_link(arg)
      # {ThirdRail.Worker, arg}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: ThirdRail.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  def config_change(changed, _new, removed) do
    ThirdRailWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
