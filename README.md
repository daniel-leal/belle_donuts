# 🍩 Belle Donuts - Administration Panel

This repository contains the source code of Belle Donuts, an administration panel developed using Elixir and Phoenix. Belle Donuts is a system designed for delivery restaurants that sell donuts. It allows for product management, order tracking, and configuration of opening hours. Additionally, it provides APIs for integration with the digital menu.

## 📋 Prerequisites

Before getting started with the configuration and execution of Belle Donuts, make sure your development environment meets the following prerequisites:

- Elixir (version 1.11 or higher)
- Erlang (version 23 or higher)
- Phoenix (version 1.6 or higher)
- PostgreSQL (version 10 or higher)

## ⚙️ Installation

Follow the steps below to set up the development environment and run Belle Donuts:

1. Clone this repository to your local environment:

   ```shell
   git clone https://github.com/your-username/belle_donuts.git
   ```

2. Navigate to the project directory:

   ```shell
   cd belle_donuts
   ```

3. Install project dependencies:

   ```shell
   mix deps.get
   ```

4. Configure the database in the config/dev.exs file. Ensure that the configurations are correct for your local environment.

5. Create and migrate the database:

   ```shell
   mix ecto.setup
   ```

6. Start the Phoenix server:

   ```shell
   mix phx.server
   ```

7. Open a web browser and access http://localhost:4000 to access the Belle Donuts administration panel.

8. The credentials are on the seeds.exs file

## 🚀 Usage

Belle Donuts provides an intuitive interface for managing products, orders, and opening hours. Through the administration panel, you can perform the following tasks:

- Add, edit, and delete products, including information such as name, description, price, and availability.
- View the list of orders, including details such as customer, ordered items, and status.
- Update the status of orders as they are processed.
- Configure the restaurant's opening hours.

Additionally, Belle Donuts offers APIs for integration with the digital menu. These APIs allow other systems to consume data from Belle Donuts to display the menu in mobile apps, websites, and more.

## 🤝 Contributing

If you would like to contribute to the development of Belle Donuts, please follow the steps below:

1. Fork this repository and clone it to your local environment.

2. Create a new branch for your contribution:

   ```shell
   git checkout -b my-contribution
   ```

3. Make the desired changes to the code.

4. Run tests to ensure that the system is functioning correctly:

   ```shell
   mix test
   ```

5. Commit your changes:

   ```shell
   git commit -m "My Contribution"
   ```

6. Push the changes to your forked repository:

   ```shell
   git push origin my-contribution
   ```

7. Open a pull request in this repository, describing your contribution and any relevant details.

Thank you for considering contributing to Belle Donuts! Your help is greatly appreciated. 💜

I hope this meets your requirements! Let me know if there's anything else I can assist you with.
