defmodule BelleDonutsWeb.ProductLive.Show do
  use BelleDonutsWeb, :live_view

  alias BelleDonuts.Catalog
  alias Catalog.Queries

  @impl true
  def mount(_params, _session, socket) do
    socket = assign(socket, :categories, Queries.list_categories())

    {:ok, socket}
  end

  @impl true
  def handle_params(%{"id" => id}, _, socket) do
    {:ok, product} = Queries.get_product(id)

    {:noreply,
     socket
     |> assign(:page_title, page_title(socket.assigns.live_action))
     |> assign(:product, product)}
  end

  defp page_title(:show), do: "Exibir"
  defp page_title(:edit), do: "Editar"
end
