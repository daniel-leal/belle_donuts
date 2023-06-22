defmodule BelleDonuts.Orders.OrderStatus do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "order_status" do
    field :status_name, :string

    timestamps()
  end

  @doc false
  def changeset(order_status, attrs) do
    order_status
    |> cast(attrs, [:status_name])
    |> validate_required([:status_name])
  end
end
