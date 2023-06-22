defmodule BelleDonutsWeb.DisplayOrderComponent do
  use Phoenix.Component

  @doc """
  Renders value as currency

  ## Examples

    <.display_order order_id=order_id />
  """
  attr :order_id, :string, required: true

  def display_order(assigns) do
    ~H"""
    <span>#<%= String.slice(@order_id, 0, 8) %></span>
    """
  end
end
