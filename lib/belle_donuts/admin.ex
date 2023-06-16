defmodule BelleDonuts.Admin do
  @moduledoc """
  The Admin context.
  """

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

  @doc """
  Creates a operating_hour.

  ## Examples

      iex> create_operating_hour(%{field: value})
      {:ok, %OperatingHour{}}

      iex> create_operating_hour(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_operating_hour(attrs \\ %{}) do
    %OperatingHour{}
    |> OperatingHour.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a operating_hour.

  ## Examples

      iex> update_operating_hour(operating_hour, %{field: new_value})
      {:ok, %OperatingHour{}}

      iex> update_operating_hour(operating_hour, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_operating_hour(%OperatingHour{} = operating_hour, attrs) do
    operating_hour
    |> OperatingHour.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a operating_hour.

  ## Examples

      iex> delete_operating_hour(operating_hour)
      {:ok, %OperatingHour{}}

      iex> delete_operating_hour(operating_hour)
      {:error, %Ecto.Changeset{}}

  """
  def delete_operating_hour(%OperatingHour{} = operating_hour) do
    Repo.delete(operating_hour)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking operating_hour changes.

  ## Examples

      iex> change_operating_hour(operating_hour)
      %Ecto.Changeset{data: %OperatingHour{}}

  """
  def change_operating_hour(%OperatingHour{} = operating_hour, attrs \\ %{}) do
    OperatingHour.changeset(operating_hour, attrs)
  end
end
