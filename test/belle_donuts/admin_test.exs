defmodule BelleDonuts.AdminTest do
  use BelleDonuts.DataCase

  alias BelleDonuts.Admin

  describe "operating_hour" do
    alias BelleDonuts.Admin
    alias Admin.{OperatingHour, Queries}

    @invalid_attrs %{"closing_time" => nil, "day" => nil, "opening_time" => nil}

    test "list_operating_hour/0 returns all operating_hour" do
      operating_hour = insert(:operating_hour)
      assert Queries.list_operating_hour() == [operating_hour]
    end

    test "get_operating_hour!/1 returns the operating_hour with given id" do
      operating_hour = insert(:operating_hour)
      assert Queries.get_operating_hour!(operating_hour.id) == operating_hour
    end

    test "create_operating_hour/1 with valid data creates a operating_hour" do
      valid_attrs = params_for(:operating_hour)

      assert {:ok, %OperatingHour{} = operating_hour} = Admin.create_operating_hour(valid_attrs)
      assert operating_hour.closing_time == valid_attrs.closing_time
      assert operating_hour.day == valid_attrs.day
      assert operating_hour.opening_time == valid_attrs.opening_time
    end

    test "create_operating_hour/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Admin.create_operating_hour(@invalid_attrs)
    end

    test "update_operating_hour/2 with valid data updates the operating_hour" do
      operating_hour = insert(:operating_hour)

      update_attrs = %{
        "id" => operating_hour.id,
        "closing_time" => "some updated closing_time",
        "day" => "some updated day",
        "opening_time" => "some updated opening_time"
      }

      assert {:ok, %OperatingHour{} = operating_hour} = Admin.update_operating_hour(update_attrs)

      assert operating_hour.closing_time == "some updated closing_time"
      assert operating_hour.day == "some updated day"
      assert operating_hour.opening_time == "some updated opening_time"
    end

    test "update_operating_hour/2 with invalid data returns error changeset" do
      operating_hour = insert(:operating_hour)

      assert {:error, %Ecto.Changeset{}} =
               Admin.update_operating_hour(Map.put(@invalid_attrs, "id", operating_hour.id))

      assert operating_hour == Queries.get_operating_hour!(operating_hour.id)
    end

    test "delete_operating_hour/1 deletes the operating_hour" do
      operating_hour = insert(:operating_hour)
      assert {:ok, %OperatingHour{}} = Admin.delete_operating_hour(operating_hour)
      assert_raise Ecto.NoResultsError, fn -> Queries.get_operating_hour!(operating_hour.id) end
    end

    test "change_operating_hour/1 returns a operating_hour changeset" do
      operating_hour = insert(:operating_hour)
      assert %Ecto.Changeset{} = Admin.change_operating_hour(operating_hour)
    end
  end
end
