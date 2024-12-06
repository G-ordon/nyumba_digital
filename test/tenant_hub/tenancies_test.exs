defmodule TenantHub.TenanciesTest do
  use TenantHub.DataCase

  alias TenantHub.Tenancies

  describe "tenancy_agreements" do
    alias TenantHub.Tenancies.TenancyAgreement

    import TenantHub.TenanciesFixtures

    @invalid_attrs %{tenant_name: nil, tenant_address: nil, tenant_phone: nil, rent: nil, deposit: nil, start_date: nil, end_date: nil}

    test "list_tenancy_agreements/0 returns all tenancy_agreements" do
      tenancy_agreement = tenancy_agreement_fixture()
      assert Tenancies.list_tenancy_agreements() == [tenancy_agreement]
    end

    test "get_tenancy_agreement!/1 returns the tenancy_agreement with given id" do
      tenancy_agreement = tenancy_agreement_fixture()
      assert Tenancies.get_tenancy_agreement!(tenancy_agreement.id) == tenancy_agreement
    end

    test "create_tenancy_agreement/1 with valid data creates a tenancy_agreement" do
      valid_attrs = %{tenant_name: "some tenant_name", tenant_address: "some tenant_address", tenant_phone: "some tenant_phone", rent: "120.5", deposit: "120.5", start_date: ~D[2024-11-06], end_date: ~D[2024-11-06]}

      assert {:ok, %TenancyAgreement{} = tenancy_agreement} = Tenancies.create_tenancy_agreement(valid_attrs)
      assert tenancy_agreement.tenant_name == "some tenant_name"
      assert tenancy_agreement.tenant_address == "some tenant_address"
      assert tenancy_agreement.tenant_phone == "some tenant_phone"
      assert tenancy_agreement.rent == Decimal.new("120.5")
      assert tenancy_agreement.deposit == Decimal.new("120.5")
      assert tenancy_agreement.start_date == ~D[2024-11-06]
      assert tenancy_agreement.end_date == ~D[2024-11-06]
    end

    test "create_tenancy_agreement/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Tenancies.create_tenancy_agreement(@invalid_attrs)
    end

    test "update_tenancy_agreement/2 with valid data updates the tenancy_agreement" do
      tenancy_agreement = tenancy_agreement_fixture()
      update_attrs = %{tenant_name: "some updated tenant_name", tenant_address: "some updated tenant_address", tenant_phone: "some updated tenant_phone", rent: "456.7", deposit: "456.7", start_date: ~D[2024-11-07], end_date: ~D[2024-11-07]}

      assert {:ok, %TenancyAgreement{} = tenancy_agreement} = Tenancies.update_tenancy_agreement(tenancy_agreement, update_attrs)
      assert tenancy_agreement.tenant_name == "some updated tenant_name"
      assert tenancy_agreement.tenant_address == "some updated tenant_address"
      assert tenancy_agreement.tenant_phone == "some updated tenant_phone"
      assert tenancy_agreement.rent == Decimal.new("456.7")
      assert tenancy_agreement.deposit == Decimal.new("456.7")
      assert tenancy_agreement.start_date == ~D[2024-11-07]
      assert tenancy_agreement.end_date == ~D[2024-11-07]
    end

    test "update_tenancy_agreement/2 with invalid data returns error changeset" do
      tenancy_agreement = tenancy_agreement_fixture()
      assert {:error, %Ecto.Changeset{}} = Tenancies.update_tenancy_agreement(tenancy_agreement, @invalid_attrs)
      assert tenancy_agreement == Tenancies.get_tenancy_agreement!(tenancy_agreement.id)
    end

    test "delete_tenancy_agreement/1 deletes the tenancy_agreement" do
      tenancy_agreement = tenancy_agreement_fixture()
      assert {:ok, %TenancyAgreement{}} = Tenancies.delete_tenancy_agreement(tenancy_agreement)
      assert_raise Ecto.NoResultsError, fn -> Tenancies.get_tenancy_agreement!(tenancy_agreement.id) end
    end

    test "change_tenancy_agreement/1 returns a tenancy_agreement changeset" do
      tenancy_agreement = tenancy_agreement_fixture()
      assert %Ecto.Changeset{} = Tenancies.change_tenancy_agreement(tenancy_agreement)
    end
  end
end
