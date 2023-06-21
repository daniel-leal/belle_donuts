# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     BelleDonuts.Repo.insert!(%BelleDonuts.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.

alias BelleDonuts.Identity
alias BelleDonuts.Orders

Identity.register_user(%{
  email: "danielleal94@gmail.com",
  password: "OklIunasdnG-@2"
})

Orders.create_order_status(%{status_name: "waiting"})
Orders.create_order_status(%{status_name: "preparing"})
Orders.create_order_status(%{status_name: "outbound_delivery"})
Orders.create_order_status(%{status_name: "deliverd"})
Orders.create_order_status(%{status_name: "canceled"})
