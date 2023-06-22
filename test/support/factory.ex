defmodule Support.Factory do
  use ExMachina.Ecto, repo: BelleDonuts.Repo

  alias BelleDonuts.Admin.OperatingHour
  alias BelleDonuts.Catalog
  alias BelleDonuts.Orders.{Order, OrderItems, OrderStatus}
  alias Catalog.Category
  alias Catalog.Product

  def product_factory do
    %Product{
      description: "Description of product",
      image_url: "https://image.com/img.png",
      name: "Donut",
      price: Decimal.new("25.45"),
      type: "Single",
      active: true
    }
  end

  def category_factory do
    %Category{
      description: sequence(:description, ["Tradicional", "Vegano"])
    }
  end

  def operating_hour_factory do
    %OperatingHour{
      day:
        sequence(:day, [
          "segunda-feira",
          "terça-feira",
          "quarta-feira",
          "quinta-feira",
          "sexta-feira"
        ]),
      opening_time: "08:00",
      closing_time: "22:00"
    }
  end

  def order_status_factory do
    %OrderStatus{
      status_name: "waiting"
    }
  end

  def order_factory do
    %Order{
      complement: "Apt 1104",
      district: "Telégrafo",
      number: "946",
      postal_code: "66113010",
      street: "Tv. Djalma Dutra",
      total_value: Decimal.new("0"),
      name: "Yasmin",
      email: "yasmin@email.com",
      phone_number: "(91) 99986-1498",
      status: build(:order_status),
      inserted_at: Timex.now()
    }
  end

  def with_order_items(order, number_of_records \\ 1, attrs \\ %{}) do
    insert_list(number_of_records, :order_items, attrs, order: order)
  end

  def order_items_factory do
    %OrderItems{
      quantity: 1,
      order: build(:order),
      product: build(:product)
    }
  end
end
