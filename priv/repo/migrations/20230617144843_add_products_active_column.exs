defmodule BelleDonuts.Repo.Migrations.AddProductsActiveColumn do
  use Ecto.Migration

  def change do
    alter table(:products) do
      add :active, :boolean, default: true
    end
  end
end
