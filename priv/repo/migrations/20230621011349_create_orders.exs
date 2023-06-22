defmodule BelleDonuts.Repo.Migrations.CreateOrders do
  use Ecto.Migration

  def change do
    create table(:orders, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :postal_code, :string
      add :street, :string
      add :number, :string
      add :district, :string
      add :complement, :string
      add :total_value, :decimal
      add :status_id, references(:order_status, on_delete: :nothing, type: :binary_id)

      timestamps()
    end

    create index(:orders, [:status_id])
  end
end
