defmodule BelleDonutsWeb.PageController do
  use BelleDonutsWeb, :controller

  alias BelleDonuts.Catalog.Queries, as: CatalogQueries

  def home(conn, _params) do
    conn
    |> assign(:products, CatalogQueries.list_products_home())
    |> assign(:products_count, CatalogQueries.count_products())
    |> render(:home, layout: {BelleDonutsWeb.Layouts, :principal})
  end
end
