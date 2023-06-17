defmodule BelleDonutsWeb.PageController do
  use BelleDonutsWeb, :controller

  alias BelleDonuts.Catalog

  def home(conn, _params) do
    conn
    |> assign(:products, Catalog.list_products_home())
    |> assign(:products_count, Catalog.count_products())
    |> render(:home, layout: {BelleDonutsWeb.Layouts, :principal})
  end
end
