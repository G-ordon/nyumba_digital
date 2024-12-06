defmodule TenantHub.Repo.Migrations.CreateTenancyAgreements do
  use Ecto.Migration

  def change do
    create table(:tenancy_agreements) do
      add :tenant_name, :string
      add :tenant_address, :string
      add :tenant_phone, :string
      add :rent, :decimal
      add :deposit, :decimal
      add :start_date, :date
      add :end_date, :date

      timestamps(type: :utc_datetime)
    end
  end

  defp table_exists?(table) do
    # Query to check if the table exists
    query = "SELECT EXISTS (SELECT 1 FROM information_schema.tables WHERE table_name = '#{table}')"
    case Ecto.Adapters.SQL.query(TenantHub.Repo, query, []) do
      {:ok, %Postgrex.Result{rows: [[true]]}} -> true
      _ -> false
    end
  end
end
