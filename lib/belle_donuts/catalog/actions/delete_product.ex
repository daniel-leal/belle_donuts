defmodule BelleDonuts.Catalog.Actions.DeleteProduct do
  alias BelleDonuts.Catalog.Product
  alias BelleDonuts.Repo

  @doc """
  Deletes a product.

  ## Examples

      iex> call(product)
      {:ok, %Product{}}

      iex> call(product)
      {:error, %Ecto.Changeset{}}

  """
  def call(%Product{} = product) do
    Repo.delete(product)
  end
end
