defmodule BelleDonuts.Admin.Actions.Delete do
  alias BelleDonuts.Admin.OperatingHour
  alias BelleDonuts.Repo

  @doc """
  Deletes a operating_hour.

  ## Examples

      iex> call(operating_hour)
      {:ok, %OperatingHour{}}

      iex> call(operating_hour)
      {:error, %Ecto.Changeset{}}

  """
  def call(%OperatingHour{} = operating_hour) do
    Repo.delete(operating_hour)
  end
end
