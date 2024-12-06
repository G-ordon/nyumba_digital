defmodule TenantHub.Tenancies.TenancyAgreement do
  use Ecto.Schema
  import Ecto.Changeset

  schema "tenancy_agreements" do
    field :tenant_name, :string
    field :tenant_address, :string
    field :tenant_phone, :string
    field :rent, :decimal
    field :deposit, :decimal
    field :start_date, :date
    field :end_date, :date
    field :submitted, :boolean, default: false
    field :agreement_content, :string
    field :signature, :binary
    field :signed_at, :utc_datetime
    field :unique_identifier, :string
    field :is_read_only, :boolean, default: false
    belongs_to :user, TenantHub.Accounts.User

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(tenancy_agreement, attrs) do
    tenancy_agreement
    |> cast(attrs, [:tenant_name, :tenant_address, :tenant_phone, :rent, :deposit, :start_date, :end_date, :submitted])
    |> validate_required([:tenant_name, :user_id, :tenant_address, :tenant_phone, :rent, :deposit, :start_date, :end_date])
    |> unique_constraint(:unique_identifier)
  end
end
