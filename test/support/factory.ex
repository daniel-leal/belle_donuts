defmodule Support.Factory do
  use ExMachina.Ecto, repo: BelleDonuts.Repo

  alias BelleDonuts.Catalog
  alias Catalog.Product
  alias Catalog.Category

  def product_factory do
    %Product{
      description: "Description of product",
      image_url: "https://image.com/img.png",
      name: "Donut",
      price: Decimal.new("25.45"),
      type: "Single"
    }
  end

  def category_factory do
    %Category{
      description: sequence(:description, ["Tradicional", "Vegano"])
    }
  end
end
