defmodule BelleDonuts.Orders.Actions.CreateOrderStatus do
  alias BelleDonuts.Orders.OrderStatus
  alias BelleDonuts.Repo

  @doc """
  Creates a order_status.

  ## Examples

      iex> call(%{field: value})
      {:ok, %OrderStatus{}}

      iex> call(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def call(params \\ %{}) do
    %OrderStatus{}
    |> OrderStatus.changeset(params)
    |> Repo.insert()
  end
end
