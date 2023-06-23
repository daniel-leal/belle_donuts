defmodule BelleDonutsWeb.Api.OrderJSON do
  alias BelleDonuts.Orders.{Order, OrderItems}
  alias BelleDonuts.Repo

  @doc """
  Renders a single order.
  """
  def show(%{order: %{order: %Order{} = order, items: items}}) do
    %{data: data(order, items)}
  end

  defp data(%Order{} = order, items) do
    %{
      order_id: order.id,
      order_date: order.inserted_at,
      total: order.total_value,
      status: order.status_id,
      postal_code: order.postal_code,
      street: order.street,
      number: order.number,
      district: order.district,
      complement: order.complement,
      name: order.name,
      email: order.email,
      phone_number: order.phone_number,
      items: for(item <- items, do: data_items(item))
    }
  end

  defp data_items(%OrderItems{} = item) do
    item = Repo.preload(item, :product)

    %{
      product: item.product.name,
      quantity: item.quantity
    }
  end
end
