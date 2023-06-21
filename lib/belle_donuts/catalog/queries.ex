defmodule BelleDonuts.Catalog.Queries do
  import Ecto.Query, warn: false
  alias BelleDonuts.Repo

  alias BelleDonuts.Catalog.Category
  alias BelleDonuts.Catalog.Product

  @doc """
  Returns the list of categories.

  ## Examples

      iex> list_categories()
      [%Category{}, ...]

  """
  def list_categories do
    Repo.all(Category)
  end

  @doc """
  Gets a single category.

  Raises `Ecto.NoResultsError` if the Category does not exist.

  ## Examples

      iex> get_category!(123)
      %Category{}

      iex> get_category!(456)
      ** (Ecto.NoResultsError)

  """
  def get_category!(id), do: Repo.get!(Category, id)

  @doc """
  Returns the list products.

  ## Examples

      iex> list_products()
      [%Product{}, ...]

  """
  def list_products do
    category_query = preload_category_query()
    query = from(p in Product, preload: [category: ^category_query])
    Repo.all(query)
  end

  @doc """
  Returns the list products.

  ## Examples

      iex> list_products()
      [%Product{}, ...]

  """
  def list_active_products do
    category_query = preload_category_query()
    query = from(p in Product, where: p.active, preload: [category: ^category_query])
    Repo.all(query)
  end

  @doc """
  Retrieves the count of active products from the `Products` table.

  ## Examples

      iex> count_products()
      9

  """
  def count_products do
    Repo.one(from(p in Product, where: p.active, select: count(p.id)))
  end

  @doc """
  Returns the list of five latest products.

  ## Examples

      iex> list_products()
      [%Product{}, ...]

  """
  def list_products_home do
    category_query = preload_category_query()

    query =
      from(p in Product,
        preload: [category: ^category_query],
        limit: 5,
        order_by: [desc: :inserted_at]
      )

    Repo.all(query)
  end

  @doc """
  Gets a single product.

  ## Examples

      iex> get_product!(123)
      %Product{}

      iex> get_product!(456)
      {:error, :not_found}

  """
  def get_product(id) do
    category_query = preload_category_query()

    case Repo.get(Product, id) do
      nil ->
        {:error, :not_found}

      %Product{} = product ->
        {:ok, Repo.preload(product, category: category_query)}
    end
  end

  @doc """
  Gets a product price.

  ## Examples

      iex> get_product_price_by_id(123)
      7.00

      iex> get_product_price_by_id(456)
      nil

  """
  def get_product_price_by_id(id) do
    case Repo.get(Product, id) do
      nil ->
        {:error, :product_not_found}

      %Product{} = product ->
        {:ok, product.price}
    end
  end

  defp preload_category_query do
    from(c in Category, select: c.description, order_by: :description)
  end
end
