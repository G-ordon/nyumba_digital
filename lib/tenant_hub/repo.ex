defmodule TenantHub.Repo do
  use Ecto.Repo,
    otp_app: :tenant_hub,
    adapter: Ecto.Adapters.Postgres
end
