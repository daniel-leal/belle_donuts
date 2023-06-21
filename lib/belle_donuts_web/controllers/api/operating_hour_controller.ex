defmodule BelleDonutsWeb.Api.OperatingHourController do
  use BelleDonutsWeb, :controller

  alias BelleDonuts.Admin.Queries

  action_fallback(BelleDonutsWeb.FallbackController)

  def index(conn, _params) do
    operating_hours = Queries.list_operating_hour()
    render(conn, :index, operating_hours: operating_hours)
  end
end
