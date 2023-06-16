defmodule BelleDonuts.Repo.Migrations.CreateOperatingHour do
  use Ecto.Migration

  def change do
    create table(:operating_hour, primary_key: false) do
      add(:id, :binary_id, primary_key: true)
      add(:day, :string)
      add(:opening_time, :string)
      add(:closing_time, :string)

      timestamps()
    end

    create(unique_index(:operating_hour, :day))
  end
end
