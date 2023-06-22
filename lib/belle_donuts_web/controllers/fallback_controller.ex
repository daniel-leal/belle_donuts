defmodule BelleDonutsWeb.FallbackController do
  @moduledoc """
  Translates controller action results into valid `Plug.Conn` responses.

  See `Phoenix.Controller.action_fallback/1` for more details.
  """
  use BelleDonutsWeb, :controller

  # This clause is an example of how to handle resources that cannot be found.
  def call(conn, {:error, :not_found}) do
    conn
    |> put_status(:not_found)
    |> put_view(html: BelleDonutsWeb.ErrorHTML, json: BelleDonutsWeb.Api.ErrorJSON)
    |> render(:"404")
  end

  def call(conn, {:error, :bad_request}) do
    conn
    |> put_status(:bad_request)
    |> put_view(html: BelleDonutsWeb.ErrorHTML, json: BelleDonutsWeb.Api.ErrorJSON)
    |> render(:"400")
  end

  def call(conn, {:error, %Ecto.Changeset{} = changeset}) do
    conn
    |> put_status(:unprocessable_entity)
    |> put_view(json: BelleDonutsWeb.Api.ChangesetJSON)
    |> render(:error, changeset: changeset)
  end
end
