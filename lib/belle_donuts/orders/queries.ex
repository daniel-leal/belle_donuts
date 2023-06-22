defmodule BelleDonuts.Orders.Queries do
  import Ecto.Query, warn: false

  alias BelleDonuts.Orders.{Order, OrderItems, OrderStatus}
  alias BelleDonuts.Repo
  alias BelleDonuts.Utils

  @doc """
  Gets a single order_status.

  Raises `Ecto.NoResultsError` if the Order status does not exist.

  ## Examples

      iex> get_order_status!(123)
      %OrderStatus{}

      iex> get_order_status!(456)
      ** (Ecto.NoResultsError)

  """
  def get_order_status!(id), do: Repo.get!(OrderStatus, id)

  @doc """
  Returns the list of five most recent orders.

  ## Examples

      iex> list_most_recent_orders()
      [%Order{}, ...]

  """
  def list_most_recent_orders do
    query = from(o in Order, limit: 4, order_by: [desc: o.inserted_at])
    Repo.all(query)
  end

  @doc """
  Gets a single order.

  Raises `Ecto.NoResultsError` if the Order does not exist.

  ## Examples

      iex> get_order!(123)
      %Order{}

      iex> get_order!(456)
      ** (Ecto.NoResultsError)

  """
  def get_order!(id), do: Repo.get!(Order, id)

  @doc """
  Returns the list of order_items.

  ## Examples

      iex> list_order_items()
      [%OrderItems{}, ...]

  """
  def list_order_items do
    Repo.all(OrderItems)
  end

  @doc """
  Gets a single order_items.

  Raises `Ecto.NoResultsError` if the Order items does not exist.

  ## Examples

      iex> get_order_items!(123)
      %OrderItems{}

      iex> get_order_items!(456)
      ** (Ecto.NoResultsError)

  """
  def get_order_items!(id), do: Repo.get!(OrderItems, id)

  @doc """
  Gets a single order_status by name.

  ## Examples

      iex> get_order_status_by_name!("waiting")
      %OrderStatus{}

      iex> get_order_status_by_name!("invalid")
      ** nil

  """
  def get_order_status_by_name(status_name) do
    query = from(os in OrderStatus, where: os.status_name == ^status_name)
    Repo.one(query)
  end

  @doc """
  Returns the total number of orders placed in the current month.

  ## Examples

      iex> get_current_month_total_orders()
      5

  """
  def get_current_month_total_orders do
    query = current_month_orders_query()
    Repo.one(from(order in query, select: count(order.id)))
  end

  @doc """
  Returns the total number of products sold in the current month.

  ## Examples

      iex> get_current_month_sold_products()
      Decimal.new("5")

  """
  def get_current_month_sold_products do
    current_month_order_query = current_month_orders_query()

    Repo.one(
      from(order in current_month_order_query,
        join: order_items in OrderItems,
        on: order_items.order_id == order.id,
        select: sum(order_items.quantity)
      )
    ) || 0
  end

  @doc """
  Returns the total value of sales in the current month

  ## Examples

      iex> get_current_month_income
      Decimal.new("200.85")

  """
  def get_current_month_income do
    current_month_order_query = current_month_orders_query()

    Repo.one(
      from(order in current_month_order_query,
        select: sum(order.total_value)
      )
    ) || Decimal.new("0.00")
  end

  defp current_month_orders_query do
    first_day_of_month = Utils.get_first_day_of_current_month()
    last_day_of_month = Utils.get_last_day_of_current_month()

    from(o in Order,
      where: o.inserted_at >= ^first_day_of_month and o.inserted_at <= ^last_day_of_month
    )
  end
end
