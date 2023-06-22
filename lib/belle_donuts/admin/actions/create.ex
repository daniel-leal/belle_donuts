defmodule BelleDonuts.Admin.Actions.Create do
  alias BelleDonuts.Admin.OperatingHour
  alias BelleDonuts.Repo

  @doc """
  Creates a operating_hour.

  ## Examples

      iex> create_operating_hour(%{field: value})
      {:ok, %OperatingHour{}}

      iex> create_operating_hour(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def call(attrs \\ %{}) do
    %OperatingHour{}
    |> OperatingHour.changeset(attrs)
    |> Repo.insert()
  end
end
