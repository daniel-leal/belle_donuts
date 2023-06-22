defmodule BelleDonutsWeb.Api.OrderJSON do
  alias BelleDonuts.Orders.{Order, OrderItems}

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
      items: for(item <- items, do: data_items(item))
    }
  end

  defp data_items(%OrderItems{} = item) do
    %{
      product_id: item.product_id,
      quantity: item.quantity
    }
  end
end
