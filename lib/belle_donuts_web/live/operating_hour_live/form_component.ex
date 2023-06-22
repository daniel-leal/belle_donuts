defmodule BelleDonutsWeb.OperatingHourLive.FormComponent do
  use BelleDonutsWeb, :live_component

  alias BelleDonuts.Admin

  @impl true
  def render(assigns) do
    ~H"""
    <div>
      <.header>
        <%= @title %>
      </.header>

      <.simple_form
        for={@form}
        id="operating_hour-form"
        phx-target={@myself}
        phx-change="validate"
        phx-submit="save"
      >
        <.input
          field={@form[:day]}
          type="select"
          label="Dia"
          prompt="Selecione o dia"
          options={@days_of_week}
        />
        <.input
          field={@form[:opening_time]}
          type="select"
          label="Hora de Abertura"
          prompt="Selecione a hora"
          options={@hours}
        />
        <.input
          field={@form[:closing_time]}
          type="select"
          label="Hora de Fechamento"
          prompt="Selecione a hora"
          options={@hours}
        />
        <:actions>
          <.button phx-disable-with="Salvando...">Salvar</.button>
        </:actions>
      </.simple_form>
    </div>
    """
  end

  @impl true
  def update(%{operating_hour: operating_hour} = assigns, socket) do
    changeset = Admin.change_operating_hour(operating_hour)

    {:ok,
     socket
     |> assign(assigns)
     |> assign_form(changeset)}
  end

  @impl true
  def handle_event("validate", %{"operating_hour" => operating_hour_params}, socket) do
    changeset =
      socket.assigns.operating_hour
      |> Admin.change_operating_hour(operating_hour_params)
      |> Map.put(:action, :validate)

    {:noreply, assign_form(socket, changeset)}
  end

  def handle_event("save", %{"operating_hour" => operating_hour_params}, socket) do
    save_operating_hour(socket, socket.assigns.action, operating_hour_params)
  end

  defp save_operating_hour(socket, :edit, operating_hour_params) do
    operating_hour_id = socket.assigns.operating_hour.id
    operating_hour_params = Map.put(operating_hour_params, "id", operating_hour_id)

    case Admin.update_operating_hour(operating_hour_params) do
      {:ok, operating_hour} ->
        notify_parent({:saved, operating_hour})

        {:noreply,
         socket
         |> put_flash(:info, "Hora de operação alterada com sucesso!")
         |> push_patch(to: socket.assigns.patch)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign_form(socket, changeset)}
    end
  end

  defp save_operating_hour(socket, :new, operating_hour_params) do
    case Admin.create_operating_hour(operating_hour_params) do
      {:ok, operating_hour} ->
        notify_parent({:saved, operating_hour})

        {:noreply,
         socket
         |> put_flash(:info, "Hora de operação incluída com sucesso!")
         |> push_patch(to: socket.assigns.patch)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign_form(socket, changeset)}
    end
  end

  defp assign_form(socket, %Ecto.Changeset{} = changeset) do
    assign(socket, :form, to_form(changeset))
  end

  defp notify_parent(msg), do: send(self(), {__MODULE__, msg})
end
