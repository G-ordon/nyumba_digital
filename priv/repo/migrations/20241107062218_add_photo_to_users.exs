defmodule TenantHub.Repo.Migrations.AddPhotoToUsers do
  use Ecto.Migration

  def change do

    alter table(:users) do
      add :photo_path, :string

    end
  end
end
