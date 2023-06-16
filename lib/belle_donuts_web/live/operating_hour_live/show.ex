defmodule BelleDonutsWeb.OperatingHourLive.Show do
  use BelleDonutsWeb, :live_view

  alias BelleDonuts.Admin

  @impl true
  def mount(_params, _session, socket) do
    {:ok, socket}
  end

  @impl true
  def handle_params(%{"id" => id}, _, socket) do
    {:noreply,
     socket
     |> assign(:page_title, page_title(socket.assigns.live_action))
     |> assign(:operating_hour, Admin.get_operating_hour!(id))}
  end

  defp page_title(:show), do: "Show Operating hour"
  defp page_title(:edit), do: "Edit Operating hour"
end
