defmodule BelleDonuts.Orders.Actions.CreateOrder do
  alias BelleDonuts.Catalog.Queries, as: CatalogQueries
  alias BelleDonuts.Orders.Queries, as: OrderQueries
  alias BelleDonuts.Orders.{Order, OrderItems}
  alias BelleDonuts.Repo
  alias Ecto

  @doc """
  Creates an order with order_items

  ## Examples

      iex> call(%{field: value})
      {:ok, %{order: order, order_items: order_items}}

      iex> call(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def call(order_data) do
    Ecto.Multi.new()
    |> Ecto.Multi.run(:create_order, fn _, _ ->
      create_order(order_data)
    end)
    |> Ecto.Multi.run(:create_order_items, fn _repo, %{create_order: order} ->
      products = Map.get(order_data, "products")
      create_order_items(order, products)
    end)
    |> Repo.transaction()
    |> handle_transaction()
  end

  defp create_order(order_data) do
    with {:ok, total_value} <- calculate_total_value(order_data["products"]),
         order_changeset <- build_order_changeset(order_data, total_value) do
      Repo.insert(order_changeset)
    end
  end

  defp create_order_items(order, products) do
    Enum.reduce_while(products, {:ok, []}, fn product, {:ok, acc} ->
      quantity = Map.get(product, "quantity", 1)

      case Repo.insert(
             OrderItems.changeset(%{
               product_id: product["product_id"],
               quantity: quantity,
               order_id: order.id
             })
           ) do
        {:ok, order_item} -> {:cont, {:ok, [order_item | acc]}}
        {:error, %Ecto.Changeset{} = changeset} -> {:halt, {:error, changeset}}
        _ -> {:halt, {:error, :insert_item_failed}}
      end
    end)
  end

  defp build_order_changeset(order_data, total_value) do
    waiting_status = Order.order_status().waiting |> OrderQueries.get_order_status_by_name()

    order_data
    |> Map.take(["postal_code", "street", "number", "district", "complement"])
    |> Map.put_new("status_id", waiting_status.id)
    |> Map.put_new("total_value", total_value)
    |> Order.create_changeset()
  end

  defp calculate_total_value(products) when is_nil(products) do
    {:error, products: {"can't be blank", [validation: :required]}}
  end

  defp calculate_total_value(products) do
    total =
      Enum.reduce(products, Decimal.new(0), fn product, acc ->
        quantity = Map.get(product, "quantity", 1)

        with {:ok, product_price} <- CatalogQueries.get_product_price_by_id(product["product_id"]) do
          item_total = Decimal.mult(product_price, Decimal.new(quantity))
          Decimal.add(acc, item_total)
        end
      end)

    {:ok, total}
  end

  defp handle_transaction(transaction) do
    case transaction do
      {:ok, %{create_order: order, create_order_items: order_items}} ->
        {:ok, %{order: order, items: order_items}}

      {:error, _action, changeset, _} ->
        {:error, changeset}
    end
  end
end
