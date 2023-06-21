defmodule BelleDonutsWeb.Api.OrderController do
  use BelleDonutsWeb, :controller

  alias BelleDonuts.Orders

  action_fallback(BelleDonutsWeb.FallbackController)

  def create(conn, params) do
    with {:ok, order} <- Orders.create_order(params) do
      conn
      |> put_status(:created)
      |> render(:show, order: order)
    end
  end
end
