defmodule BelleDonuts.Utils do
  @now Timex.now()

  def get_last_day_of_current_month, do: Timex.end_of_month(@now)
  def get_first_day_of_current_month, do: Timex.beginning_of_month(@now)
  def get_month_before, do: Timex.shift(@now, months: -1)
end
