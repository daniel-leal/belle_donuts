defmodule BelleDonuts.AdminFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `BelleDonuts.Admin` context.
  """

  @doc """
  Generate a operating_hour.
  """
  def operating_hour_fixture(attrs \\ %{}) do
    {:ok, operating_hour} =
      attrs
      |> Enum.into(%{
        closing_time: "some closing_time",
        day: "some day",
        opening_time: "some opening_time"
      })
      |> BelleDonuts.Admin.create_operating_hour()

    operating_hour
  end
end
