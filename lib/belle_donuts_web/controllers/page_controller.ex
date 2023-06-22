defmodule BelleDonutsWeb.PageController do
  use BelleDonutsWeb, :controller

  alias BelleDonuts.Catalog.Queries, as: CatalogQueries
  alias BelleDonuts.Orders.Queries, as: OrdersQueries

  def home(conn, _params) do
    conn
    |> assign(:products, CatalogQueries.list_products_home())
    |> assign(:products_count, CatalogQueries.count_products())
    |> assign(:products_sold, OrdersQueries.get_current_month_sold_products())
    |> assign(:income, OrdersQueries.get_current_month_income())
    |> assign(:orders_count, OrdersQueries.get_current_month_total_orders())
    |> assign(:orders, OrdersQueries.list_most_recent_orders())
    |> render(:home, layout: {BelleDonutsWeb.Layouts, :principal})
  end
end
