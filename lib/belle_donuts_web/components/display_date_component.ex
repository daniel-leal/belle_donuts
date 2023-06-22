defmodule BelleDonutsWeb.DisplayDateComponent do
  use Phoenix.Component
  use Timex

  @doc """
  Renders value as currency

  ## Examples

    <.display_relative_time date=date />
    "2 minutos atrás"
  """
  attr :date, :string, required: true

  def display_relative_time(assigns) do
    ~H"""
    <span><%= get_relative_time(@date) %></span>
    """
  end

  def get_relative_time(date) do
    {:ok, relative_str} = Timex.lformat(date, "{relative}", "pt", :relative)
    relative_str
  end
end
