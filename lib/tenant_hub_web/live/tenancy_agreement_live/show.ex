defmodule TenantHubWeb.TenancyAgreementLive.Show do
  use TenantHubWeb, :live_view

  alias TenantHub.Tenancies

  @impl true
  def mount(_params, _session, socket) do
    {:ok, socket}
  end

  @impl true
  def handle_params(%{"id" => id}, _, socket) do
    {:noreply,
     socket
     |> assign(:page_title, page_title(socket.assigns.live_action))
     |> assign(:tenancy_agreement, Tenancies.get_tenancy_agreement!(id))}
  end

  defp page_title(:show), do: "Show Tenancy agreement"
  defp page_title(:edit), do: "Edit Tenancy agreement"
end
