defmodule BelleDonutsWeb.ProductLive.FormComponent do
  use BelleDonutsWeb, :live_component

  alias BelleDonuts.Catalog
  alias BelleDonutsWeb.Helpers

  @impl true
  def render(assigns) do
    ~H"""
    <div>
      <.header>
        <%= @title %>
        <:subtitle>
          Use este formulário para cadastrar ou editar os produtos que serão listados no cardápio digital
        </:subtitle>
      </.header>

      <.simple_form
        for={@form}
        id="product-form"
        phx-target={@myself}
        phx-change="validate"
        phx-submit="save"
      >
        <.input field={@form[:name]} type="text" label="Nome" />
        <.input field={@form[:price]} type="number" label="Preço" step="any" />
        <.input field={@form[:description]} type="textarea" label="Descrição" />
        <.input
          field={@form[:category_id]}
          type="select"
          label="Categoria"
          prompt="Selecione uma categoria"
          options={Enum.map(@categories, &{&1.description, &1.id})}
        />
        <.input
          field={@form[:type]}
          type="select"
          label="Tipo"
          options={Helpers.list_product_types()}
        />
        <.input field={@form[:image_url]} type="text" label="URL da Imagem" />
        <.input field={@form[:active]} type="checkbox" label="Ativo" />

        <:actions>
          <.button phx-disable-with="Salvando...">Salvar</.button>
        </:actions>
      </.simple_form>
    </div>
    """
  end

  @impl true
  def update(%{product: product} = assigns, socket) do
    changeset = Catalog.change_product(product)

    {:ok,
     socket
     |> assign(assigns)
     |> assign_form(changeset)}
  end

  @impl true
  def handle_event("validate", %{"product" => product_params}, socket) do
    changeset =
      socket.assigns.product
      |> Catalog.change_product(product_params)
      |> Map.put(:action, :validate)

    {:noreply, assign_form(socket, changeset)}
  end

  def handle_event("save", %{"product" => product_params}, socket) do
    save_product(socket, socket.assigns.action, product_params)
  end

  defp save_product(socket, :edit, product_params) do
    case Catalog.update_product(socket.assigns.product, product_params) do
      {:ok, product} ->
        notify_parent({:saved, product})

        {:noreply,
         socket
         |> put_flash(:info, "Produto atualizado com sucesso!")
         |> push_patch(to: socket.assigns.patch)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign_form(socket, changeset)}
    end
  end

  defp save_product(socket, :new, product_params) do
    case Catalog.create_product(product_params) do
      {:ok, product} ->
        notify_parent({:saved, product})

        {:noreply,
         socket
         |> put_flash(:info, "Produto incluído com sucesso!")
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
