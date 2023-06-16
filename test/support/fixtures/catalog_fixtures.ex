defmodule BelleDonuts.CatalogFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `BelleDonuts.Catalog` context.
  """

  @doc """
  Generate a product.
  """
  def product_fixture(attrs \\ %{}) do
    {:ok, product} =
      attrs
      |> Enum.into(%{
        description: "some description",
        image_url: "some image_url",
        name: "some name",
        price: "120.5",
        type: "some type"
      })
      |> BelleDonuts.Catalog.create_product()

    product
  end

  @doc """
  Generate a category.
  """
  def category_fixture(attrs \\ %{}) do
    {:ok, category} =
      attrs
      |> Enum.into(%{
        description: "some description"
      })
      |> BelleDonuts.Catalog.create_category()

    category
  end
end
