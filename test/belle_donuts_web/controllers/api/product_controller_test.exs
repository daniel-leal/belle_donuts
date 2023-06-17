defmodule BelleDonutsWeb.ProductControllerTest do
  use BelleDonutsWeb.ConnCase

  setup %{conn: conn} do
    category = insert(:category)
    insert_list(3, :product, category: category)
    product = insert(:product, category: category)

    {:ok, conn: put_req_header(conn, "accept", "application/json"), product: product}
  end

  describe "index" do
    test "lists all products", %{conn: conn} do
      conn = get(conn, ~p"/api/products")

      assert json_response(conn, 200)
      assert length(json_response(conn, 200)["data"]) == 4
    end

    test "list all active products", %{conn: conn} do
      insert_list(2, :product, active: false)

      conn = get(conn, ~p"/api/products")

      assert json_response(conn, 200)
      assert length(json_response(conn, 200)["data"]) == 4
    end
  end

  describe "show" do
    test "get product details", %{conn: conn, product: product} do
      conn = get(conn, ~p"/api/products/#{product}")

      assert response(conn, 200)
    end

    test "get not found when pass invalid id", %{conn: conn} do
      uuid = Ecto.UUID.generate()
      conn = get(conn, ~p"/api/products/#{uuid}")

      assert response(conn, 404)
    end
  end
end
