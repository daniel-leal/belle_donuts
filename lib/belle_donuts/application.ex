defmodule BelleDonuts.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      # Start the Telemetry supervisor
      BelleDonutsWeb.Telemetry,
      # Start the Ecto repository
      BelleDonuts.Repo,
      # Start the PubSub system
      {Phoenix.PubSub, name: BelleDonuts.PubSub},
      # Start Finch
      {Finch, name: BelleDonuts.Finch},
      # Start the Endpoint (http/https)
      BelleDonutsWeb.Endpoint
      # Start a worker by calling: BelleDonuts.Worker.start_link(arg)
      # {BelleDonuts.Worker, arg}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: BelleDonuts.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    BelleDonutsWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
