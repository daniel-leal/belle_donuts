defmodule BelleDonuts.Orders.QueriesTest do
  use BelleDonuts.DataCase

  alias BelleDonuts.Orders.Queries

  setup do
    insert(:order_status, status_name: "waiting")
    product1 = insert(:product, price: Decimal.new("5.00"))
    product2 = insert(:product, price: Decimal.new("10.00"))

    {:ok, product1: product1, product2: product2}
  end

  describe "get_current_month_sold_products" do
    test "get current month sold products count", %{product1: product1, product2: product2} do
      insert(:order) |> with_order_items(3, product: product1, quantity: 2)
      insert(:order) |> with_order_items(2, product: product2, quantity: 1)

      query = Queries.get_current_month_sold_products()
      assert query == Decimal.new("8")
    end

    test "get current month sold products without orders" do
      query = Queries.get_current_month_sold_products()
      assert query == 0
    end
  end

  describe "get_current_month_total_orders" do
    test "get current month total orders count" do
      insert_list(5, :order)

      query = Queries.get_current_month_total_orders()
      assert query == 5
    end

    test "get current month total orders count without orders" do
      query = Queries.get_current_month_total_orders()
      assert query == 0
    end
  end

  describe "get_current_month_income" do
    test "get current month total sales query", %{product1: product1, product2: product2} do
      insert(:order, total_value: Decimal.new("30"))
      |> with_order_items(3, product: product1, quantity: 2)

      insert(:order, total_value: Decimal.new("50"))
      |> with_order_items(2, product: product2, quantity: 1)

      query = Queries.get_current_month_income()
      assert query == Decimal.new("80")
    end

    test "get current month total sales query without orders" do
      query = Queries.get_current_month_income()
      assert query == Decimal.new("0.00")
    end
  end
end
