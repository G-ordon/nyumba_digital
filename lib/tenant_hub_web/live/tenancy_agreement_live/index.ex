defmodule TenantHubWeb.TenancyAgreementLive.Index do
  use TenantHubWeb, :live_view

  alias TenantHub.Tenancies
  alias TenantHub.Accounts
  alias TenantHub.Tenancies.TenancyAgreement
  alias TenantHub.Accounts.User


@impl true
def mount(_params, %{"user_token" => user_token}, socket) do
  case Accounts.get_user_by_session_token(user_token) do
    %User{} = user ->
      # Fetch the tenancy agreement for the current user
      tenancy_agreements = Tenancies.list_tenancy_agreements_for_user(user.id)

      # Assign the tenancy agreements to the socket
      socket = assign(socket, :tenancy_agreements, tenancy_agreements)
      socket = assign(socket, :current_user, user)

      # Initialize stream for tenancy agreements
      socket = socket |> stream(:tenancy_agreements, tenancy_agreements)

      # Check if there is any tenancy agreement and if it has been submitted
      can_edit = case tenancy_agreements do
        [] -> true  # No agreement, so can edit (create new)
        [agreement] ->
          if agreement.submitted do
            false  # Agreement is already submitted, cannot edit
          else
            true  # Agreement exists but not submitted, can edit
          end
      end

      # Return socket with the correct page title and editing permissions
      {:ok, socket |> assign(:can_edit, can_edit) |> assign(:page_title, if(can_edit, do: "New Tenancy Agreement", else: "View Tenancy Agreement"))}

    nil ->
      {:ok, push_navigate(socket, to: "/login")}
  end
end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :edit, %{"id" => id}) do
    socket
    |> assign(:page_title, "Edit Tenancy Agreement")
    |> assign(:tenancy_agreement, Tenancies.get_tenancy_agreement!(id))
  end

  defp apply_action(socket, :new, _params) do
    socket
    |> assign(:page_title, "New Tenancy Agreement")
    |> assign(:tenancy_agreement, %TenancyAgreement{})
  end

  defp apply_action(socket, :index, _params) do
    socket
    |> assign(:page_title, "Listing Tenancy Agreements")
    |> assign(:tenancy_agreement, nil)
  end

  @impl true
  def handle_info({TenantHubWeb.TenancyAgreementLive.FormComponent, {:saved, tenancy_agreement}}, socket) do
    {:noreply, stream_insert(socket, :tenancy_agreements, tenancy_agreement)}
  end

  @impl true
  def handle_event("delete", %{"id" => id}, socket) do
    tenancy_agreement = Tenancies.get_tenancy_agreement!(id)
    {:ok, _} = Tenancies.delete_tenancy_agreement(tenancy_agreement)
    {:noreply, stream_delete(socket, :tenancy_agreements, tenancy_agreement)}
  end
end
