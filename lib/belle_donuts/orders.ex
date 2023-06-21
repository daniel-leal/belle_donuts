defmodule BelleDonuts.Orders do
  @moduledoc """
  The Orders context.
  """

  alias BelleDonuts.Orders.Actions.ChangeOrderStatus
  alias BelleDonuts.Orders.Actions.CreateOrderStatus
  alias BelleDonuts.Orders.Actions.DeleteOrderStatus
  alias BelleDonuts.Orders.Actions.UpdateOrderStatus

  defdelegate create_order_status(params \\ %{}), to: CreateOrderStatus, as: :call
  defdelegate update_order_status(order_status, params), to: UpdateOrderStatus, as: :call
  defdelegate delete_order_status(order_status), to: DeleteOrderStatus, as: :call
  defdelegate change_order_status(order_status, params \\ %{}), to: ChangeOrderStatus, as: :call

  alias BelleDonuts.Orders.Actions.CreateOrder

  defdelegate create_order(params), to: CreateOrder, as: :call
end
