defmodule TenantHubWeb.UserProfileLive do
  use TenantHubWeb, :live_view

  alias TenantHub.Accounts

  def mount(_params, session, socket) do
    user_token = session["user_token"]

    case Accounts.get_user_by_session_token(user_token) do
      nil ->
        {:error, redirect(socket, to: "/log_in")}

      user ->
        {:ok, assign(socket, current_user: user)}
    end
  end

  def render(assigns) do
    ~H"""
    <div class="profile-container">
      <div class="profile-header">
        <%= if @current_user.photo do %>
          <img
            src={"/uploads/users/photos/#{@current_user.id}/photo.jpg"}
            alt="Profile Photo"
            class="profile-photo"
          />
        <% else %>
          <div class="profile-photo-placeholder">No Photo</div>
        <% end %>
        <h2 class="profile-name"><%= @current_user.full_names %></h2>
      </div>

      <div class="profile-details">
        <div>
          <h4>Email</h4>
          <p><%= @current_user.email %></p>
        </div>
        <div>
          <h4>Role</h4>
          <p><%= @current_user.role %></p>
        </div>
        <div>
          <h4>Organization</h4>
          <p><%= @current_user.organization %></p>
        </div>
        <div>
          <h4>Postal Address</h4>
          <p><%= @current_user.postal_address %></p>
        </div>
        <div>
          <h4>Telephone</h4>
          <p><%= @current_user.telephone_number %></p>
        </div>
        <div>
          <h4>Nationality</h4>
          <p><%= @current_user.nationality %></p>
        </div>
        <div>
          <h4>Identification Number</h4>
          <p><%= @current_user.identification_number %></p>
        </div>
        <div>
          <h4>Next of Kin</h4>
          <p><%= @current_user.next_of_kin %></p>
        </div>
        <div>
          <h4>Next of Kin Contact</h4>
          <p><%= @current_user.next_of_kin_contact %></p>
        </div>
      </div>

      <div class="profile-actions">
        <.link navigate={~p"/user/dashboard"} class="back-btn">Back to Dashboard</.link>
      </div>
    </div>
    """
  end
end
