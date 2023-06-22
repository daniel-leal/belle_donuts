defmodule BelleDonuts.Catalog.Actions.UpdateCategory do
  alias BelleDonuts.Catalog.Category
  alias BelleDonuts.Repo

  @doc """
  Updates a category.

  ## Examples

      iex> call(category, %{field: new_value})
      {:ok, %Category{}}

      iex> call(category, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def call(%Category{} = category, attrs) do
    category
    |> Category.changeset(attrs)
    |> Repo.update()
  end
end
