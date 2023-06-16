defmodule BelleDonuts.Repo do
  use Ecto.Repo,
    otp_app: :belle_donuts,
    adapter: Ecto.Adapters.Postgres
end
