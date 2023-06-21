defmodule BelleDonuts.Catalog do
  @moduledoc """
  The Catalog context.
  """

  alias BelleDonuts.Catalog.Actions.ChangeCategory, as: ChangeCategory
  alias BelleDonuts.Catalog.Actions.CreateCategory, as: CreateCategory
  alias BelleDonuts.Catalog.Actions.DeleteCategory, as: DeleteCategory
  alias BelleDonuts.Catalog.Actions.UpdateCategory, as: UpdateCategory

  defdelegate create_category(params), to: CreateCategory, as: :call
  defdelegate update_category(category, params \\ %{}), to: UpdateCategory, as: :call
  defdelegate delete_category(category), to: DeleteCategory, as: :call
  defdelegate change_category(category, params \\ %{}), to: ChangeCategory, as: :call

  alias BelleDonuts.Catalog.Actions.ChangeProduct, as: ChangeProduct
  alias BelleDonuts.Catalog.Actions.CreateProduct, as: CreateProduct
  alias BelleDonuts.Catalog.Actions.DeleteProduct, as: DeleteProduct
  alias BelleDonuts.Catalog.Actions.UpdateProduct, as: UpdateProduct

  defdelegate create_product(params), to: CreateProduct, as: :call
  defdelegate update_product(product, params \\ %{}), to: UpdateProduct, as: :call
  defdelegate delete_product(product), to: DeleteProduct, as: :call
  defdelegate change_product(product, params \\ %{}), to: ChangeProduct, as: :call
end
