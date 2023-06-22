defmodule BelleDonuts.Repo.Migrations.CreateOrderStatus do
  use Ecto.Migration

  def change do
    create table(:order_status, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :status_name, :string

      timestamps()
    end
  end
end
