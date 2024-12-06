defmodule TenantHub.Repo.Migrations.AddSubmittedToTenancyAgreements do
  use Ecto.Migration

  def change do
  alter table(:tenancy_agreements) do
    add :submitted, :boolean, default: false
  end
  end
end
