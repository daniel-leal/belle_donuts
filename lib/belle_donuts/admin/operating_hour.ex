defmodule BelleDonuts.Admin.OperatingHour do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "operating_hour" do
    field(:closing_time, :string)
    field(:day, :string)
    field(:opening_time, :string)

    timestamps()
  end

  @doc false
  def changeset(operating_hour, attrs) do
    operating_hour
    |> cast(attrs, [:day, :opening_time, :closing_time])
    |> validate_required([:day, :opening_time, :closing_time])
    |> unique_constraint(:day)
  end
end
