defmodule BelleDonuts.Catalog.Actions.CreateProduct do
  alias BelleDonuts.Catalog.Product
  alias BelleDonuts.Repo

  @doc """
  Creates a product.

  ## Examples

      iex> call(%{field: value})
      {:ok, %Product{}}

      iex> call(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def call(attrs \\ %{}) do
    %Product{}
    |> Product.changeset(attrs)
    |> Repo.insert()
  end
end
