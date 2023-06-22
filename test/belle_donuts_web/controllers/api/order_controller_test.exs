defmodule BelleDonutsWeb.Api.OrderControllerTest do
  use BelleDonutsWeb.ConnCase

  setup %{conn: conn} do
    insert(:order_status, status_name: "waiting")
    product = insert(:product)

    {:ok, conn: put_req_header(conn, "accept", "application/json"), product: product}
  end

  describe "create" do
    test "create_order with valid params", %{conn: conn, product: product} do
      body = %{
        "products" => [
          %{"product_id" => product.id, "quantity" => 3}
        ],
        "postal_code" => "66113010",
        "street" => "Tv. Djalma Dutra",
        "number" => "946",
        "district" => "Telégrafo",
        "complement" => "Apt 1104",
        "name" => "Yasmin",
        "email" => "yasmin@email.com",
        "phone_number" => "(91) 99986-1498"
      }

      expected = %{
        "complement" => "Apt 1104",
        "district" => "Telégrafo",
        "items" => [
          %{"product_id" => product.id, "quantity" => "3"}
        ],
        "number" => "946",
        "postal_code" => "66113010",
        "street" => "Tv. Djalma Dutra",
        "total" => "76.35",
        "name" => "Yasmin",
        "email" => "yasmin@email.com",
        "phone_number" => "(91) 99986-1498"
      }

      conn = post(conn, ~p"/api/orders", body)

      response = json_response(conn, 201)["data"]

      assert json_response(conn, 201)
      assert Map.has_key?(response, "order_id")
      assert Map.has_key?(response, "status")
      assert Map.has_key?(response, "order_date")
      assert Map.drop(response, ["order_id", "status", "order_date"]) == expected
    end

    test "create_order with ivalid order params", %{conn: conn} do
      body = %{
        "products" => [],
        "postal_code" => "",
        "street" => "",
        "number" => "",
        "district" => "",
        "complement" => ""
      }

      conn = post(conn, ~p"/api/orders", body)

      expected = %{
        "complement" => ["can't be blank"],
        "district" => ["can't be blank"],
        "number" => ["can't be blank"],
        "postal_code" => ["can't be blank"],
        "street" => ["can't be blank"],
        "email" => ["can't be blank"],
        "name" => ["can't be blank"],
        "phone_number" => ["can't be blank"]
      }

      assert json_response(conn, 422)
      assert json_response(conn, 422)["errors"] == expected
    end
  end
end
