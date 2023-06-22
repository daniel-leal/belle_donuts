defmodule BelleDonuts.Orders.Order do
  use Ecto.Schema
  use EnumType
  import Ecto.Changeset

  alias BelleDonuts.Orders.OrderItems
  alias BelleDonuts.Orders.OrderStatus

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id

  defenum Status do
    value(Waiting, "waiting")
    value(Preparing, "preparing")
    value(OutboundDelivery, "outbound_delivery")
    value(Delivered, "delivered")
    value(Canceled, "canceled")
  end

  schema "orders" do
    field(:complement, :string)
    field(:district, :string)
    field(:number, :string)
    field(:postal_code, :string)
    field(:street, :string)
    field(:total_value, :decimal)
    field(:name, :string)
    field(:email, :string)
    field(:phone_number, :string)

    has_many :order_items, OrderItems
    belongs_to :status, OrderStatus

    timestamps()
  end

  @doc false
  def changeset(order \\ %__MODULE__{}, params) do
    order
    |> cast(params, [
      :postal_code,
      :street,
      :number,
      :district,
      :complement,
      :total_value,
      :status_id,
      :name,
      :email,
      :phone_number
    ])
    |> validate_required([
      :postal_code,
      :street,
      :number,
      :district,
      :complement,
      :status_id,
      :total_value,
      :name,
      :email,
      :phone_number
    ])
    |> validate_format(:email, ~r/\A[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,}\z/)
    |> validate_format(:phone_number, ~r/\(\d{2}\) \d{5}-\d{4}/)
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
end
