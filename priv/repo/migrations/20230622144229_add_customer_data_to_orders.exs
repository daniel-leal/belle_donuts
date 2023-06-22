defmodule BelleDonuts.Repo.Migrations.AddCustomerDataToOrders do
  use Ecto.Migration

  def change do
    alter table(:orders) do
      add :name, :string, limit: 50
      add :email, :string, limit: 50
      add :phone_number, :string, limit: 20
    end
  end
end
