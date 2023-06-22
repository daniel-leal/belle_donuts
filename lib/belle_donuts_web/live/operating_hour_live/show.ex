defmodule BelleDonutsWeb.OperatingHourLive.Show do
  use BelleDonutsWeb, :live_view

  alias BelleDonuts.Admin.Queries
  alias BelleDonutsWeb.Helpers

  @impl true
  def mount(_params, _session, socket) do
    socket =
      socket
      |> assign(
        :days_of_week,
        Helpers.get_week_days()
      )
      |> assign(
        :hours,
        Helpers.list_hours()
      )

    {:ok, socket}
  end

  @impl true
  def handle_params(%{"id" => id}, _, socket) do
    {:noreply,
     socket
     |> assign(:page_title, page_title(socket.assigns.live_action))
     |> assign(:operating_hour, Queries.get_operating_hour!(id))}
  end

  defp page_title(:show), do: "Exibir"
  defp page_title(:edit), do: "Editar"
end
