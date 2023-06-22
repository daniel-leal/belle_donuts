defmodule BelleDonuts.Orders.Actions.UpdateOrderStatus do
  alias BelleDonuts.Orders.OrderStatus
  alias BelleDonuts.Repo

  @doc """
  Updates a order_status.

  ## Examples

      iex> call(order_status, %{field: new_value})
      {:ok, %OrderStatus{}}

      iex> call(order_status, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def call(%OrderStatus{} = order_status, params) do
    order_status
    |> OrderStatus.changeset(params)
    |> Repo.update()
  end
end
