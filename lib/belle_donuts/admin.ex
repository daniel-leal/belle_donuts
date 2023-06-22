defmodule BelleDonuts.Admin do
  @moduledoc """
  The Admin context.
  """
  alias BelleDonuts.Admin.Actions.Change, as: OperatingHourChange
  alias BelleDonuts.Admin.Actions.Create, as: OperatingHourCreate
  alias BelleDonuts.Admin.Actions.Delete, as: OperatingHourDelete
  alias BelleDonuts.Admin.Actions.Update, as: OperatingHourUpdate

  defdelegate create_operating_hour(params), to: OperatingHourCreate, as: :call
  defdelegate update_operating_hour(params), to: OperatingHourUpdate, as: :call
  defdelegate delete_operating_hour(operating_hour), to: OperatingHourDelete, as: :call

  defdelegate change_operating_hour(operating_hour, params \\ %{}),
    to: OperatingHourChange,
    as: :call
end
