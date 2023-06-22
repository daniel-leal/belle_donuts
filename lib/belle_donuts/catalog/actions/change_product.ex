defmodule BelleDonuts.Catalog.Actions.ChangeProduct do
  alias BelleDonuts.Catalog.Product

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking product changes.

  ## Examples

      iex> call(product)
      %Ecto.Changeset{data: %Product{}}

  """
  def call(%Product{} = product, attrs \\ %{}) do
    Product.changeset(product, attrs)
  end
end
