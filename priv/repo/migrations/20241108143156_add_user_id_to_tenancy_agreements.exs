defmodule TenantHub.Repo.Migrations.AddUserIdToTenancyAgreements do
  use Ecto.Migration

  def change do
   alter table(:tenancy_agreements) do
     add :user_id, :integer
   end

  create index(:tenancy_agreements, [:user_id])
  end
end
