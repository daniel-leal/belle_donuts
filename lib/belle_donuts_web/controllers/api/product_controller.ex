defmodule BelleDonutsWeb.Api.ProductController do
  use BelleDonutsWeb, :controller

  alias BelleDonuts.Catalog.Queries

  action_fallback(BelleDonutsWeb.FallbackController)

  def index(conn, _params) do
    products = Queries.list_active_products()
    render(conn, :index, products: products)
  end

  def show(conn, %{"id" => id}) do
    with {:ok, product} <- Queries.get_product(id) do
      render(conn, :show, product: product)
    end
  end
end
