defmodule BelleDonuts.Catalog do
  @moduledoc """
  The Catalog context.
  """

  import Ecto.Query, warn: false
  alias BelleDonuts.Repo

  alias BelleDonuts.Catalog.Category
  alias BelleDonuts.Catalog.Product

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

  ## Returns

  - If there are active products, returns the count as an integer.
  - If there are no active products, returns `nil`.

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

  Raises `Ecto.NoResultsError` if the Product does not exist.

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
  Creates a product.

  ## Examples

      iex> create_product(%{field: value})
      {:ok, %Product{}}

      iex> create_product(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_product(attrs \\ %{}) do
    %Product{}
    |> Product.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a product.

  ## Examples

      iex> update_product(product, %{field: new_value})
      {:ok, %Product{}}

      iex> update_product(product, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_product(%Product{} = product, attrs) do
    product
    |> Product.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a product.

  ## Examples

      iex> delete_product(product)
      {:ok, %Product{}}

      iex> delete_product(product)
      {:error, %Ecto.Changeset{}}

  """
  def delete_product(%Product{} = product) do
    Repo.delete(product)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking product changes.

  ## Examples

      iex> change_product(product)
      %Ecto.Changeset{data: %Product{}}

  """
  def change_product(%Product{} = product, attrs \\ %{}) do
    Product.changeset(product, attrs)
  end

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
  Creates a category.

  ## Examples

      iex> create_category(%{field: value})
      {:ok, %Category{}}

      iex> create_category(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_category(attrs \\ %{}) do
    %Category{}
    |> Category.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a category.

  ## Examples

      iex> update_category(category, %{field: new_value})
      {:ok, %Category{}}

      iex> update_category(category, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_category(%Category{} = category, attrs) do
    category
    |> Category.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a category.

  ## Examples

      iex> delete_category(category)
      {:ok, %Category{}}

      iex> delete_category(category)
      {:error, %Ecto.Changeset{}}

  """
  def delete_category(%Category{} = category) do
    Repo.delete(category)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking category changes.

  ## Examples

      iex> change_category(category)
      %Ecto.Changeset{data: %Category{}}

  """
  def change_category(%Category{} = category, attrs \\ %{}) do
    Category.changeset(category, attrs)
  end

  defp preload_category_query do
    from(c in Category, select: c.description, order_by: :description)
  end
end
