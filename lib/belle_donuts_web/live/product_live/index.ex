defmodule BelleDonutsWeb.ProductLive.Index do
  use BelleDonutsWeb, :live_view

  alias BelleDonuts.Catalog
  alias BelleDonuts.Catalog.Product

  @impl true
  def mount(_params, _session, socket) do
    socket =
      socket
      |> assign(:categories, Catalog.list_categories())
      |> stream(:products, Catalog.list_products())

    {:ok, socket}
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :edit, %{"id" => id}) do
    {:ok, product} = Catalog.get_product(id)

    socket
    |> assign(:page_title, "Editar")
    |> assign(:product, product)
  end

  defp apply_action(socket, :new, _params) do
    socket
    |> assign(:page_title, "Incluir")
    |> assign(:product, %Product{})
  end

  defp apply_action(socket, :index, _params) do
    socket
    |> assign(:page_title, "Listagem de produtos")
    |> assign(:product, nil)
  end

  @impl true
  def handle_info({BelleDonutsWeb.ProductLive.FormComponent, {:saved, product}}, socket) do
    {:noreply, stream_insert(socket, :products, product)}
  end

  @impl true
  def handle_event("delete", %{"id" => id}, socket) do
    with {:ok, product} <- Catalog.get_product(id),
         {:ok, _} <- Catalog.delete_product(product) do
      {:noreply, stream_delete(socket, :products, product)}
    end
  end
end
