defmodule TenantHubWeb.UserDashboardLive do
  use TenantHubWeb, :live_view

  alias TenantHub.Accounts
  alias TenantHub.Tenancies
  #alias TenantHub.Repo

  @impl true
  def render(assigns) do
    ~H"""
    <div class="dashboard">
      <!-- Sidebar -->
      <div class="sidebar">
        <h3>Welcome, <%= @user.full_names %></h3>
        <ul>
          <li><.link navigate={~p"/tenant/profile"}>Profile</.link></li>
          <li><.link navigate={~p"/tenancy_agreements"}>Tenancy Agreement</.link></li>
          <li><.link navigate={~p"/dashboard/settings"}>Settings</.link></li>
          <li><.link navigate={~p"/"}>Back Home</.link></li>
        </ul>
      </div>

      <!-- Main Content -->
      <div class="main-content">
        <h2>User Dashboard</h2>

        <%= if @section == "profile" do %>
          <h3>Your Profile</h3>
          <p><strong>Name:</strong> <%= @user.full_names %></p>
          <p><strong>Email:</strong> <%= @user.email %></p>
          <.link navigate={~p"/tenant/profile/edit"}>Edit Profile</.link>
        <% end %>

        <%= if @section == "tenancy_agreement" do %>
          <h3>Your Tenancy Agreement</h3>
          <form phx-submit="save_agreement">
            <label for="agreement">Agreement Details:</label>
            <textarea id="agreement" name="agreement"><%= @tenancy_agreement.details %></textarea>
            <button type="submit">Save Agreement</button>
          </form>
        <% end %>

        <%= if @section == "settings" do %>
          <h3>Settings</h3>
          <p>Change your password or update notification preferences here.</p>
        <% end %>
      </div>
    </div>
    """
  end

  @impl true
  def mount(_params, %{"user_token" => token}, socket) do
    # Retrieve the current user from the session
    case Accounts.get_user_by_session_token(token) do
      nil ->
        {:redirect, to: ~p"/users/log_in"}

      user ->
        # Fetch the TenancyAgreement only for the logged-in user
        tenancy_agreement = Tenancies.get_tenancy_agreement_for_user(user.id)

        socket =
          socket
          |> assign(:user, user)
          |> assign(:tenancy_agreement, tenancy_agreement)
          |> assign(:section, "profile")

        {:ok, socket}
    end
  end

  @impl true
  def handle_params(params, _url, socket) do
    section = params["section"] || "profile"
    {:noreply, assign(socket, :section, section)}
  end

  @impl true
  def handle_event("save_agreement", %{"agreement" => agreement_details}, socket) do
    # Update the TenancyAgreement for the logged-in user
    Tenancies.update_tenancy_agreement(socket.assigns.tenancy_agreement, %{details: agreement_details})

    {:noreply, socket}
  end
end
