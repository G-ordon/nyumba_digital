defmodule TenantHub.Repo.Migrations.AddFieldsToTenancyAgreements do
  use Ecto.Migration

  def change do
  alter table(:tenancy_agreements) do
    add :agreement_content, :text
    add :signature, :binary
    add :signed_at, :utc_datetime
    add :unique_identifier, :string
    add :is_read_only, :boolean, default: false
  end

  create unique_index(:tenancy_agreements, [:unique_identifier])
  end
end
