defmodule BelleDonuts.Orders.Order do
  use Ecto.Schema
  import Ecto.Changeset

  @order_status %{
    waiting: "waiting",
    preparing: "preparing",
    outbound_delivery: "outbound_delivery",
    deliverd: "deliverd",
    canceled: "canceled"
  }
  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id

  schema "orders" do
    field(:complement, :string)
    field(:district, :string)
    field(:number, :string)
    field(:postal_code, :string)
    field(:street, :string)
    field(:total_value, :decimal)
    field(:status_id, :binary_id)

    timestamps()
  end

  @doc false
  def changeset(order \\ %__MODULE__{}, attrs) do
    order
    |> cast(attrs, [
      :postal_code,
      :street,
      :number,
      :district,
      :complement,
      :total_value,
      :status_id
    ])
    |> validate_required([:postal_code, :street, :number, :district, :complement])
  end

  @doc """
  The update_status_changeset function is responsible for creating a changeset
  that updates the status of an order.

  Returns an `%Ecto.Changeset{}`.

  ## Examples

    iex> order = %Order{}
    iex> status = %{status_id: 2}
    iex> changeset = update_status_changeset(order, status)

  """
  def update_status_changeset(order, status) do
    order
    |> cast(status, [:status_id])
    |> validate_required([:status_id])
  end

  def create_changeset(order \\ %__MODULE__{}, params) do
    order
    |> cast(params, [
      :postal_code,
      :street,
      :number,
      :district,
      :complement,
      :total_value,
      :status_id
    ])
    |> validate_required([
      :postal_code,
      :street,
      :number,
      :district,
      :complement,
      :status_id,
      :total_value
    ])
  end

  def order_status do
    @order_status
  end
end
