defmodule TenantHubWeb.UserController do
  use TenantHubWeb, :controller
  alias TenantHub.Accounts

  def delete(conn, %{"id" => id}) do
    user = Accounts.get_user!(id) # Get user by ID
    case Accounts.delete_user(user) do
      {:ok, _user} ->
        conn
        |> put_flash(:info, "User deleted successfully.")
        |> redirect(to: "/admin/dashboard") # Redirect after deletion

      {:error, _reason} ->
        conn
        |> put_flash(:error, "Failed to delete user.")
        |> redirect(to: "/admin/dashboard")
    end
  end
end
