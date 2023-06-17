defmodule BelleDonutsWeb.Api.OperatingHourJSON do
  alias BelleDonuts.Admin.OperatingHour

  @doc """
  Renders a list of operating hours
  """
  def index(%{operating_hours: operating_hours}) do
    %{data: for(operating_hour <- operating_hours, do: data(operating_hour))}
  end

  defp data(%OperatingHour{} = operating_hour) do
    %{
      day: operating_hour.day,
      operating_time: operating_hour.opening_time,
      closing_time: operating_hour.closing_time
    }
  end
end
