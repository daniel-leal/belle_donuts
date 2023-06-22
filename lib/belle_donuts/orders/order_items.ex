defmodule BelleDonuts.Orders.OrderItems do
  use Ecto.Schema
  import Ecto.Changeset

  alias BelleDonuts.Catalog.Product
  alias BelleDonuts.Orders.Order

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "order_items" do
    field :quantity, :decimal

    belongs_to :order, Order
    belongs_to :product, Product

    timestamps()
  end

  @doc false
  def changeset(order_items \\ %__MODULE__{}, attrs) do
    order_items
    |> cast(attrs, [:order_id, :product_id, :quantity])
    |> validate_required([:order_id, :product_id, :quantity])
  end
end
