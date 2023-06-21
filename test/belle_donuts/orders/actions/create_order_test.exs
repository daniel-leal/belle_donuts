defmodule BelleDonuts.Orders.Actions.CreateOrderTest do
  use BelleDonuts.DataCase

  alias BelleDonuts.Orders

  describe "create_order" do
    setup do
      insert(:order_status, status_name: "waiting")

      :ok
    end

    test "create_order creates an order and order_items when params are valid" do
      product1 = insert(:product, name: "Moranguinho", price: Decimal.new("20.00"))
      product2 = insert(:product, name: "Chocolove", price: Decimal.new("5.00"))

      valid_attrs = %{
        "products" => [
          %{"product_id" => product1.id, "quantity" => 3},
          %{"product_id" => product2.id, "quantity" => 2}
        ],
        "postal_code" => "66113010",
        "street" => "Tv. Djalma Dutra",
        "number" => "946",
        "district" => "Telégrafo",
        "complement" => "Apt 1104"
      }

      response = Orders.create_order(valid_attrs)

      assert {:ok, %{order: order, items: _}} = response
      assert order.total_value == Decimal.new("70.00")
    end

    test "create_order raise an error when order params are invalid" do
      invalid_attrs = %{
        "products" => [],
        "postal_code" => "",
        "street" => "",
        "number" => "",
        "district" => "",
        "complement" => ""
      }

      response = Orders.create_order(invalid_attrs)

      assert {:error, %Ecto.Changeset{} = changeset} = response

      assert changeset.errors == [
               postal_code: {"can't be blank", [validation: :required]},
               street: {"can't be blank", [validation: :required]},
               number: {"can't be blank", [validation: :required]},
               district: {"can't be blank", [validation: :required]},
               complement: {"can't be blank", [validation: :required]}
             ]
    end

    test "create_order raise an error when order items are invalid" do
      invalid_attrs = %{
        "postal_code" => "66113010",
        "street" => "Tv. Djalma Dutra",
        "number" => "946",
        "district" => "Telégrafo",
        "complement" => "Apt 1104"
      }

      response = Orders.create_order(invalid_attrs)

      assert response == {:error, [products: {"can't be blank", [validation: :required]}]}
    end

    test "create_order raise an error when order items are does not exist" do
      invalid_attrs = %{
        "products" => [
          %{"product_id" => Ecto.UUID.generate(), "quantity" => 3}
        ],
        "postal_code" => "66113010",
        "street" => "Tv. Djalma Dutra",
        "number" => "946",
        "district" => "Telégrafo",
        "complement" => "Apt 1104"
      }

      response = Orders.create_order(invalid_attrs)

      assert {:error, %Ecto.Changeset{} = changeset} = response

      assert changeset.errors == [
               total_value: {"is invalid", [type: :decimal, validation: :cast]}
             ]
    end
  end
end
