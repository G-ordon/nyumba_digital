defmodule TenantHubWeb.AdminDashboardLive do
  use TenantHubWeb, :live_view

  alias TenantHub.Accounts

  def mount(_params, _session, socket) do
    # Fetch all users
    users = Accounts.list_users()

    # Separate users into admin and regular user lists
    admin_users = Enum.filter(users, fn user -> user.role == "admin" end)
    regular_users = Enum.filter(users, fn user -> user.role != "admin" end)

    socket =
      socket
      |> assign(:admin_users, admin_users)
      |> assign(:regular_users, regular_users)

    {:ok, socket}
  end

  def handle_event("delete_user", %{"id" => user_id}, socket) do
    user = Accounts.get_user!(user_id)

    case Accounts.delete_user(user) do
      {:ok, _user} ->
        # Refresh both user lists
        users = Accounts.list_users()
        admin_users = Enum.filter(users, fn user -> user.role == "admin" end)
        regular_users = Enum.filter(users, fn user -> user.role != "admin" end)

        {:noreply, assign(socket, admin_users: admin_users, regular_users: regular_users)}

      {:error, _reason} ->
        {:noreply, put_flash(socket, :error, "Failed to delete user.")}
    end
  end

  def render(assigns) do
    ~H"""
    <div class="mx-auto max-w-4xl">
      <h1 class="text-2xl font-bold">Admin Dashboard</h1>

      <div class="mt-4">
        <h2 class="text-xl">Admin Users</h2>
        <table class="min-w-full border-collapse border border-gray-200 mb-8">
          <thead>
            <tr>
              <th class="border border-gray-300 px-4 py-2">ID</th>
              <th class="border border-gray-300 px-4 py-2">Email</th>
              <th class="border border-gray-300 px-4 py-2">Role</th>
              <th class="border border-gray-300 px-4 py-2">Actions</th>
            </tr>
          </thead>
          <tbody>
            <%= for user <- @admin_users do %>
              <tr>
                <td class="border border-gray-300 px-4 py-2"><%= user.id %></td>
                <td class="border border-gray-300 px-4 py-2"><%= user.email %></td>
                <td class="border border-gray-300 px-4 py-2"><%= user.role %></td>
                <td class="border border-gray-300 px-4 py-2">
                  <.link navigate={~p"/admin/users/#{user.id}/edit"} class="text-blue-600">Edit</.link>
                  <.button phx-click="delete_user" phx-value-id={user.id} class="text-red-600">Delete</.button>
                </td>
              </tr>
            <% end %>
          </tbody>
        </table>
      </div>

      <div class="mt-4">
        <h2 class="text-xl">Tenants Users</h2>
        <table class="min-w-full border-collapse border border-gray-200">
          <thead>
            <tr>
              <th class="border border-gray-300 px-4 py-2">ID</th>
              <th class="border border-gray-300 px-4 py-2">Email</th>
              <th class="border border-gray-300 px-4 py-2">Role</th>
              <th class="border border-gray-300 px-4 py-2">Actions</th>
            </tr>
          </thead>
          <tbody>
            <%= for user <- @regular_users do %>
              <tr>
                <td class="border border-gray-300 px-4 py-2"><%= user.id %></td>
                <td class="border border-gray-300 px-4 py-2"><%= user.email %></td>
                <td class="border border-gray-300 px-4 py-2"><%= user.role %></td>
                <td class="border border-gray-300 px-4 py-2">
                  <.link navigate={~p"/admin/users/#{user.id}/edit"} class="text-blue-600">Edit</.link>
                  <.button phx-click="delete_user" phx-value-id={user.id} class="text-red-600">Delete</.button>
                </td>
              </tr>
            <% end %>
          </tbody>
        </table>
      </div>
    </div>
    """
  end
end
