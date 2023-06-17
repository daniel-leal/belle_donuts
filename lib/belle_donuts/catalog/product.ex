defmodule BelleDonuts.Catalog.Product do
  use Ecto.Schema
  import Ecto.Changeset

  alias BelleDonuts.Catalog.Category

  @product_types ~w(Single Combo)

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "products" do
    field(:description, :string)
    field(:image_url, :string)
    field(:name, :string)
    field(:price, :decimal)
    field(:type, :string)
    field(:active, :boolean, default: true)
    field(:category_id, :binary_id)

    belongs_to(:category, Category, define_field: false)

    timestamps()
  end

  @doc false
  def changeset(product, attrs) do
    product
    |> cast(attrs, [:name, :price, :description, :image_url, :type, :category_id, :active])
    |> validate_required([:name, :price, :description, :image_url, :type, :category_id],
      message: "Campo obrigatório"
    )
    |> validate_inclusion(:type, @product_types)
  end
end
