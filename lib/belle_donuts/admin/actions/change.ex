defmodule BelleDonuts.Admin.Actions.Change do
  alias BelleDonuts.Admin.OperatingHour

  def call(%OperatingHour{} = operating_hour, params \\ %{}) do
    OperatingHour.changeset(operating_hour, params)
  end
end
