defmodule BelleDonuts.Catalog.Actions.DeleteCategory do
  alias BelleDonuts.Catalog.Category
  alias BelleDonuts.Repo

  @doc """
  Deletes a category.

  ## Examples

      iex> delete_category(category)
      {:ok, %Category{}}

      iex> delete_category(category)
      {:error, %Ecto.Changeset{}}

  """
  def call(%Category{} = category) do
    Repo.delete(category)
  end
end
