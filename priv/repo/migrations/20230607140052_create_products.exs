defmodule BelleDonuts.Repo.Migrations.CreateProducts do
  use Ecto.Migration

  def change do
    create table(:products, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :name, :string
      add :price, :decimal
      add :description, :string
      add :image_url, :string
      add :type, :string
      add :category_id, references(:categories, on_delete: :nothing, type: :binary_id)

      timestamps()
    end

    create index(:products, [:category_id])
  end
end
