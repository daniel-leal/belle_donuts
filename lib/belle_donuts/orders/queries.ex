defmodule BelleDonuts.Orders.Queries do
  import Ecto.Query, warn: false

  alias BelleDonuts.Orders.OrderItems
  alias BelleDonuts.Orders.OrderStatus
  alias BelleDonuts.Repo

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
  Returns the list of orders.

  ## Examples

      iex> list_orders()
      [%Order{}, ...]

  """
  def list_orders do
    Repo.all(Order)
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
end
