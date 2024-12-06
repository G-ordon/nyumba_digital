defmodule TenantHub.Repo.Migrations.AddFieldsToUsers do
  use Ecto.Migration

  def change do
    alter table(:users) do
      add :full_names, :string
      add :postal_address, :string
      add :telephone_number, :string
      add :nationality, :string
      add :organization, :string
      add :next_of_kin, :string
      add :next_of_kin_contact, :string
      add :photo, :string
      add :identification_number, :string
    end
  end
end
