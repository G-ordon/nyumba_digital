defmodule TenantHub.TenanciesFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `TenantHub.Tenancies` context.
  """

  @doc """
  Generate a tenancy_agreement.
  """
  def tenancy_agreement_fixture(attrs \\ %{}) do
    {:ok, tenancy_agreement} =
      attrs
      |> Enum.into(%{
        deposit: "120.5",
        end_date: ~D[2024-11-06],
        rent: "120.5",
        start_date: ~D[2024-11-06],
        tenant_address: "some tenant_address",
        tenant_name: "some tenant_name",
        tenant_phone: "some tenant_phone"
      })
      |> TenantHub.Tenancies.create_tenancy_agreement()

    tenancy_agreement
  end
end
