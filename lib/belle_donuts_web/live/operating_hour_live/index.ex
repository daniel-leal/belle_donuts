defmodule BelleDonutsWeb.OperatingHourLive.Index do
  use BelleDonutsWeb, :live_view

  alias BelleDonuts.Admin
  alias BelleDonuts.Admin.OperatingHour
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
      |> stream(:operating_hour_collection, Admin.list_operating_hour())

    {:ok, socket}
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :edit, %{"id" => id}) do
    socket
    |> assign(:page_title, "Edit Operating hour")
    |> assign(:operating_hour, Admin.get_operating_hour!(id))
  end

  defp apply_action(socket, :new, _params) do
    socket
    |> assign(:page_title, "New Operating hour")
    |> assign(:operating_hour, %OperatingHour{})
  end

  defp apply_action(socket, :index, _params) do
    socket
    |> assign(:page_title, "Listing Operating hour")
    |> assign(:operating_hour, nil)
  end

  @impl true
  def handle_info(
        {BelleDonutsWeb.OperatingHourLive.FormComponent, {:saved, operating_hour}},
        socket
      ) do
    {:noreply, stream_insert(socket, :operating_hour_collection, operating_hour)}
  end

  @impl true
  def handle_event("delete", %{"id" => id}, socket) do
    operating_hour = Admin.get_operating_hour!(id)
    {:ok, _} = Admin.delete_operating_hour(operating_hour)

    {:noreply, stream_delete(socket, :operating_hour_collection, operating_hour)}
  end
end
