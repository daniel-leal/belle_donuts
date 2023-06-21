defmodule BelleDonuts.Catalog.Actions.ChangeCategory do
  alias BelleDonuts.Catalog.Category

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking category changes.

  ## Examples

      iex> change_category(category)
      %Ecto.Changeset{data: %Category{}}

  """
  def call(%Category{} = category, attrs \\ %{}) do
    Category.changeset(category, attrs)
  end
end
