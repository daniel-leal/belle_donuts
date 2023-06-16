defmodule BelleDonutsWeb.Router do
  use BelleDonutsWeb, :router

  import BelleDonutsWeb.UserAuth

  pipeline :browser do
    plug(:accepts, ["html"])
    plug(:fetch_session)
    plug(:fetch_live_flash)
    plug(:put_root_layout, {BelleDonutsWeb.Layouts, :root})
    plug(:protect_from_forgery)
    plug(:put_secure_browser_headers)
    plug(:fetch_current_user)
  end

  pipeline :api do
    plug(:accepts, ["json"])
  end

  scope "/", BelleDonutsWeb do
    pipe_through(:browser)

    get("/", PageController, :home)
  end

  # Other scopes may use custom stacks.
  scope "/api", BelleDonutsWeb.Api do
    pipe_through(:api)

    get("/products", ProductController, :index)
    get("/products/:id", ProductController, :show)
  end

  # Enable LiveDashboard and Swoosh mailbox preview in development
  if Application.compile_env(:belle_donuts, :dev_routes) do
    # If you want to use the LiveDashboard in production, you should put
    # it behind authentication and allow only admins to access it.
    # If your application does not have an admins-only section yet,
    # you can use Plug.BasicAuth to set up some basic authentication
    # as long as you are also using SSL (which you should anyway).
    import Phoenix.LiveDashboard.Router

    scope "/dev" do
      pipe_through(:browser)

      live_dashboard("/dashboard", metrics: BelleDonutsWeb.Telemetry)
      forward("/mailbox", Plug.Swoosh.MailboxPreview)
    end
  end

  ## Authentication routes

  scope "/", BelleDonutsWeb do
    pipe_through([:browser, :redirect_if_user_is_authenticated])

    live_session :redirect_if_user_is_authenticated,
      on_mount: [{BelleDonutsWeb.UserAuth, :redirect_if_user_is_authenticated}] do
      live("/users/register", UserRegistrationLive, :new)
      live("/users/log_in", UserLoginLive, :new)
      live("/users/reset_password", UserForgotPasswordLive, :new)
      live("/users/reset_password/:token", UserResetPasswordLive, :edit)
    end

    post("/users/log_in", UserSessionController, :create)
  end

  scope "/", BelleDonutsWeb do
    pipe_through([:browser, :require_authenticated_user])

    live_session :require_authenticated_user,
      on_mount: [{BelleDonutsWeb.UserAuth, :ensure_authenticated}] do
      live("/users/settings", UserSettingsLive, :edit)

      live("/operating_hour", OperatingHourLive.Index, :index)
      live("/operating_hour/new", OperatingHourLive.Index, :new)
      live("/operating_hour/:id/edit", OperatingHourLive.Index, :edit)
      live("/operating_hour/:id", OperatingHourLive.Show, :show)
      live("/operating_hour/:id/show/edit", OperatingHourLive.Show, :edit)

      live("/categories", CategoryLive.Index, :index)
      live("/categories/new", CategoryLive.Index, :new)
      live("/categories/:id/edit", CategoryLive.Index, :edit)

      live("/products", ProductLive.Index, :index)
      live("/products/new", ProductLive.Index, :new)
      live("/products/:id/edit", ProductLive.Index, :edit)
      live("/products/:id", ProductLive.Show, :show)
      live("/products/:id/show/edit", ProductLive.Show, :edit)
    end
  end

  scope "/", BelleDonutsWeb do
    pipe_through([:browser])

    delete("/users/log_out", UserSessionController, :delete)
  end
end
