defmodule BelleDonutsWeb.Helpers do
  @day_names %{
    1 => "segunda-feira",
    2 => "terça-feira",
    3 => "quarta-feira",
    4 => "quinta-feira",
    5 => "sexta-feira",
    6 => "sábado",
    7 => "domingo"
  }

  def list_product_types, do: ["Single", "Combo"]

  def get_week_days do
    Enum.map(1..7, &day_of_week_name/1)
  end

  def list_hours do
    Enum.map(1..23, fn hour ->
      "#{String.pad_leading(Integer.to_string(hour), 2, "0")}:00"
    end)
  end

  defp day_of_week_name(number) do
    Map.get(@day_names, number)
  end
end
