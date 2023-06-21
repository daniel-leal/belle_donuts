defmodule BelleDonuts.Catalog.Actions.UpdateProduct do
  alias BelleDonuts.Catalog.Product
  alias BelleDonuts.Repo

  @doc """
  Updates a product.

  ## Examples

      iex> call(product, %{field: new_value})
      {:ok, %Product{}}

      iex> call(product, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def call(%Product{} = product, attrs) do
    product
    |> Product.changeset(attrs)
    |> Repo.update()
  end
end
