defmodule BelleDonuts.Orders.Actions.DeleteOrderStatus do
  alias BelleDonuts.Orders.OrderStatus
  alias BelleDonuts.Repo

  @doc """
  Deletes a order_status.

  ## Examples

      iex> call(order_status)
      {:ok, %OrderStatus{}}

      iex> call(order_status)
      {:error, %Ecto.Changeset{}}

  """
  def call(%OrderStatus{} = order_status) do
    Repo.delete(order_status)
  end
end
