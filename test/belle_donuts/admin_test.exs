defmodule BelleDonuts.AdminTest do
  use BelleDonuts.DataCase

  alias BelleDonuts.Admin

  describe "operating_hour" do
    alias BelleDonuts.Admin.OperatingHour

    import BelleDonuts.AdminFixtures

    @invalid_attrs %{closing_time: nil, day: nil, opening_time: nil}

    test "list_operating_hour/0 returns all operating_hour" do
      operating_hour = operating_hour_fixture()
      assert Admin.list_operating_hour() == [operating_hour]
    end

    test "get_operating_hour!/1 returns the operating_hour with given id" do
      operating_hour = operating_hour_fixture()
      assert Admin.get_operating_hour!(operating_hour.id) == operating_hour
    end

    test "create_operating_hour/1 with valid data creates a operating_hour" do
      valid_attrs = %{
        closing_time: "some closing_time",
        day: "some day",
        opening_time: "some opening_time"
      }

      assert {:ok, %OperatingHour{} = operating_hour} = Admin.create_operating_hour(valid_attrs)
      assert operating_hour.closing_time == "some closing_time"
      assert operating_hour.day == "some day"
      assert operating_hour.opening_time == "some opening_time"
    end

    test "create_operating_hour/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Admin.create_operating_hour(@invalid_attrs)
    end

    test "update_operating_hour/2 with valid data updates the operating_hour" do
      operating_hour = operating_hour_fixture()

      update_attrs = %{
        closing_time: "some updated closing_time",
        day: "some updated day",
        opening_time: "some updated opening_time"
      }

      assert {:ok, %OperatingHour{} = operating_hour} =
               Admin.update_operating_hour(operating_hour, update_attrs)

      assert operating_hour.closing_time == "some updated closing_time"
      assert operating_hour.day == "some updated day"
      assert operating_hour.opening_time == "some updated opening_time"
    end

    test "update_operating_hour/2 with invalid data returns error changeset" do
      operating_hour = operating_hour_fixture()

      assert {:error, %Ecto.Changeset{}} =
               Admin.update_operating_hour(operating_hour, @invalid_attrs)

      assert operating_hour == Admin.get_operating_hour!(operating_hour.id)
    end

    test "delete_operating_hour/1 deletes the operating_hour" do
      operating_hour = operating_hour_fixture()
      assert {:ok, %OperatingHour{}} = Admin.delete_operating_hour(operating_hour)
      assert_raise Ecto.NoResultsError, fn -> Admin.get_operating_hour!(operating_hour.id) end
    end

    test "change_operating_hour/1 returns a operating_hour changeset" do
      operating_hour = operating_hour_fixture()
      assert %Ecto.Changeset{} = Admin.change_operating_hour(operating_hour)
    end
  end
end
