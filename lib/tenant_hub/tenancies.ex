defmodule TenantHub.Tenancies do
  import Ecto.Query, warn: false
  alias TenantHub.Repo
  alias TenantHub.Tenancies.TenancyAgreement

  def create_agreement(attrs \\ %{}) do
    %TenancyAgreement{}
    |> TenancyAgreement.changeset(attrs)
    |> Repo.insert()
  end

  def list_agreements do
    Repo.all(TenancyAgreement)
  end

  alias TenantHub.Tenancies.TenancyAgreement

  @doc """
  Returns the list of tenancy_agreements.

  ## Examples

      iex> list_tenancy_agreements()
      [%TenancyAgreement{}, ...]

  """
  def list_tenancy_agreements_for_user(user_id) do
    Repo.all(from t in TenancyAgreement, where: t.user_id == ^user_id)
  end
  @doc """
  Gets a single tenancy_agreement.

  Raises `Ecto.NoResultsError` if the Tenancy agreement does not exist.

  ## Examples

      iex> get_tenancy_agreement!(123)
      %TenancyAgreement{}

      iex> get_tenancy_agreement!(456)
      ** (Ecto.NoResultsError)

  """

 # Fetch the tenancy agreement for a specific user by their user_id
 def get_tenancy_agreement_for_user(user_id) do
  Repo.get_by(TenancyAgreement, user_id: user_id)
end
def get_tenancy_agreement!(id), do: Repo.get!(TenancyAgreement, id)

  @doc """
  Creates a tenancy_agreement.

  ## Examples

      iex> create_tenancy_agreement(%{field: value})
      {:ok, %TenancyAgreement{}}

      iex> create_tenancy_agreement(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_tenancy_agreement(attrs \\ %{}) do
    %TenancyAgreement{}
    |> TenancyAgreement.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a tenancy_agreement.

  ## Examples

      iex> update_tenancy_agreement(tenancy_agreement, %{field: new_value})
      {:ok, %TenancyAgreement{}}

      iex> update_tenancy_agreement(tenancy_agreement, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_tenancy_agreement(%TenancyAgreement{} = tenancy_agreement, attrs) do
    tenancy_agreement
    |> TenancyAgreement.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a tenancy_agreement.

  ## Examples

      iex> delete_tenancy_agreement(tenancy_agreement)
      {:ok, %TenancyAgreement{}}

      iex> delete_tenancy_agreement(tenancy_agreement)
      {:error, %Ecto.Changeset{}}

  """
  def delete_tenancy_agreement(%TenancyAgreement{} = tenancy_agreement) do
    Repo.delete(tenancy_agreement)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking tenancy_agreement changes.

  ## Examples

      iex> change_tenancy_agreement(tenancy_agreement)
      %Ecto.Changeset{data: %TenancyAgreement{}}

  """
  def change_tenancy_agreement(%TenancyAgreement{} = tenancy_agreement, attrs \\ %{}) do
    TenancyAgreement.changeset(tenancy_agreement, attrs)
  end
end
