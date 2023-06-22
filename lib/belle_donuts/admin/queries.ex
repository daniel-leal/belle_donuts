defmodule BelleDonuts.Admin.Queries do
  import Ecto.Query, warn: false
  alias BelleDonuts.Repo

  alias BelleDonuts.Admin.OperatingHour

  @doc """
  Returns the list of operating_hour.

  ## Examples

      iex> list_operating_hour()
      [%OperatingHour{}, ...]

  """
  def list_operating_hour do
    Repo.all(OperatingHour)
  end

  @doc """
  Gets a single operating_hour.

  Raises `Ecto.NoResultsError` if the Operating hour does not exist.

  ## Examples

      iex> get_operating_hour!(123)
      %OperatingHour{}

      iex> get_operating_hour!(456)
      ** (Ecto.NoResultsError)

  """
  def get_operating_hour!(id), do: Repo.get!(OperatingHour, id)
end
