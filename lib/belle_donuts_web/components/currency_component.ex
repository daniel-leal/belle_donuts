defmodule BelleDonutsWeb.CurrencyComponent do
  use Phoenix.Component

  @doc """
  Renders value as currency

  ## Examples

    <.display_with_currency value=price />
  """
  attr :value, :string, required: true

  def display_with_currency(assigns) do
    ~H"""
    <span><%= to_currency(@value) %></span>
    """
  end

  defp to_currency(value) when is_nil(value), do: "R$ 0,00"
  defp to_currency(value), do: String.replace("R$ #{value}", ".", ",")
end
