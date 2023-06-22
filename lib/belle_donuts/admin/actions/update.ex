defmodule BelleDonuts.Admin.Actions.Update do
  alias BelleDonuts.Admin.OperatingHour
  alias BelleDonuts.Repo

  @doc """
  Updates a operating_hour.

  ## Examples

      iex> call(%{id: id, field: new_value})
      {:ok, %OperatingHour{}}

      iex> call(%{id: invalid_id, field: new_value})
      {:error, :not_found}

      iex> call(%{id: id, field: bad_field})
      {:error, %Ecto.Changeset{}}

  """
  def call(%{"id" => id} = params) do
    case Repo.get(OperatingHour, id) do
      nil -> {:error, :not_found}
      operating_hour -> do_update(operating_hour, params)
    end
  end

  defp do_update(operating_hour, params) do
    operating_hour
    |> OperatingHour.changeset(params)
    |> Repo.update()
  end
end
