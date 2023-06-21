defmodule BelleDonuts.Catalog.Actions.CreateCategory do
  alias BelleDonuts.Catalog.Category
  alias BelleDonuts.Repo

  @doc """
  Creates a category.

  ## Examples

      iex> call(%{field: value})
      {:ok, %Category{}}

      iex> call(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def call(attrs \\ %{}) do
    %Category{}
    |> Category.changeset(attrs)
    |> Repo.insert()
  end
end
