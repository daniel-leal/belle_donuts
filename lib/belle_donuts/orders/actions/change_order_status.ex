defmodule BelleDonuts.Orders.Actions.ChangeOrderStatus do
  alias BelleDonuts.Orders.OrderStatus

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking order_status changes.

  ## Examples

      iex> call(order_status)
      %Ecto.Changeset{data: %OrderStatus{}}

  """
  def call(%OrderStatus{} = order_status, params \\ %{}) do
    OrderStatus.changeset(order_status, params)
  end
end
