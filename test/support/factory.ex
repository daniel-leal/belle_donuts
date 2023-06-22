defmodule Support.Factory do
  use ExMachina.Ecto, repo: BelleDonuts.Repo

  alias BelleDonuts.Admin.OperatingHour
  alias BelleDonuts.Catalog
  alias BelleDonuts.Orders.OrderStatus
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
end
