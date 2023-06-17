defmodule BelleDonutsWeb.OperatingHourControllerTest do
  use BelleDonutsWeb.ConnCase

  setup %{conn: conn} do
    insert_list(3, :operating_hour)

    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all operating_hours", %{conn: conn} do
      conn = get(conn, ~p"/api/operating_hours")

      assert json_response(conn, 200)
      assert length(json_response(conn, 200)["data"]) == 3
    end
  end
end
