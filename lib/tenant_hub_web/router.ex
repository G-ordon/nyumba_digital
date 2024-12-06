defmodule TenantHubWeb.Router do
  use TenantHubWeb, :router

  import TenantHubWeb.UserAuth

  # Define pipelines
  pipeline :authenticated_user do
    plug :require_authenticated_user
  end

  pipeline :admin do
    plug :require_admin
  end

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_live_flash
    plug :put_root_layout, html: {TenantHubWeb.Layouts, :root}
    plug :protect_from_forgery
    plug :put_secure_browser_headers
    plug :fetch_current_user
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  # Public routes for non-authenticated users
  scope "/", TenantHubWeb do
    pipe_through :browser

    get "/", PageController, :home


  end

  # Authentication routes for users
  scope "/", TenantHubWeb do
    pipe_through [:browser, :redirect_if_user_is_authenticated]

    live_session :redirect_if_user_is_authenticated,
      on_mount: [{TenantHubWeb.UserAuth, :redirect_if_user_is_authenticated}] do
      live "/users/register", UserRegistrationLive, :new
      live "/users/log_in", UserLoginLive, :new
      live "/users/reset_password", UserForgotPasswordLive, :new
      live "/users/reset_password/:token", UserResetPasswordLive, :edit
    end

    post "/users/log_in", UserSessionController, :create
  end

  # Routes for authenticated users
  scope "/", TenantHubWeb do
    pipe_through [:browser, :require_authenticated_user]

    live_session :require_authenticated_user,
      on_mount: [{TenantHubWeb.UserAuth, :ensure_authenticated}] do
      live "/users/settings", UserSettingsLive, :edit
      live "/users/settings/confirm_email/:token", UserSettingsLive, :confirm_email

      live "/tenant/profile", UserProfileLive, :show
      live "/tenant/profile/edit", UserProfileLive, :edit
      live "/dashboard/profile", UserDashboardLive, :profile

      live "/tenancy_agreements", TenancyAgreementLive.Index, :index
      live "/tenancy_agreements/new", TenancyAgreementLive.Index, :new
      live "/tenancy_agreements/:id/edit", TenancyAgreementLive.Index, :edit
      live "/dashboard/tenancy_agreements", UserDashboardLive, :tenancy_agreements
      live "/tenancy_agreements/:id", TenancyAgreementLive.Show, :show
      live "/tenancy_agreements/:id/show/edit", TenancyAgreementLive.Show, :edit

      live "/user/dashboard", UserDashboardLive, :index
      live "/dashboard/settings", SettingsLive, :index

      #the faq's matters
      live "/faq", FaqLive
    end
  end

  # Admin-specific routes
  scope "/admin", TenantHubWeb do
    pipe_through [:browser, :require_authenticated_user, :admin]

    live "/dashboard", AdminDashboardLive, :index
    live "/users/:id/edit", UserEditLive, :edit
    delete "/users/:id", UserController, :delete

    # Admin can also access user-related pages
    live "/tenant/profile", UserProfileLive, :show
    live "/tenant/profile/edit", UserProfileLive, :edit
    live "/dashboard/profile", UserDashboardLive, :profile

    live "/tenancy_agreements", TenancyAgreementLive.Index, :index
    live "/tenancy_agreements/new", TenancyAgreementLive.Index, :new
    live "/tenancy_agreements/:id/edit", TenancyAgreementLive.Index, :edit
    live "/dashboard/tenancy_agreements", UserDashboardLive, :tenancy_agreements
    live "/tenancy_agreements/:id", TenancyAgreementLive.Show, :show
    live "/tenancy_agreements/:id/show/edit", TenancyAgreementLive.Show, :edit

    live "/user/dashboard", UserDashboardLive, :index
    live "/dashboard/settings", SettingsLive, :index
  end

  # Confirm user routes
  scope "/", TenantHubWeb do
    pipe_through [:browser]

    delete "/users/log_out", UserSessionController, :delete

    live_session :current_user,
      on_mount: [{TenantHubWeb.UserAuth, :mount_current_user}] do
      live "/users/confirm/:token", UserConfirmationLive, :edit
      live "/users/confirm", UserConfirmationInstructionsLive, :new
    end
  end

  # Admin-specific plug for the require_admin pipeline
  defp require_admin(conn, _opts) do
    if conn.assigns.current_user && conn.assigns.current_user.role == "admin" do
      conn
    else
      conn
      |> put_flash(:error, "You are not authorized to access this page.")
      |> redirect(to: "/")
      |> halt()
    end
  end
end
