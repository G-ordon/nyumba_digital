defmodule TenantHubWeb.TenancyAgreementLiveTest do
  use TenantHubWeb.ConnCase

  import Phoenix.LiveViewTest
  import TenantHub.TenanciesFixtures

  @create_attrs %{tenant_name: "some tenant_name", tenant_address: "some tenant_address", tenant_phone: "some tenant_phone", rent: "120.5", deposit: "120.5", start_date: "2024-11-06", end_date: "2024-11-06"}
  @update_attrs %{tenant_name: "some updated tenant_name", tenant_address: "some updated tenant_address", tenant_phone: "some updated tenant_phone", rent: "456.7", deposit: "456.7", start_date: "2024-11-07", end_date: "2024-11-07"}
  @invalid_attrs %{tenant_name: nil, tenant_address: nil, tenant_phone: nil, rent: nil, deposit: nil, start_date: nil, end_date: nil}

  defp create_tenancy_agreement(_) do
    tenancy_agreement = tenancy_agreement_fixture()
    %{tenancy_agreement: tenancy_agreement}
  end

  describe "Index" do
    setup [:create_tenancy_agreement]

    test "lists all tenancy_agreements", %{conn: conn, tenancy_agreement: tenancy_agreement} do
      {:ok, _index_live, html} = live(conn, ~p"/tenancy_agreements")

      assert html =~ "Listing Tenancy agreements"
      assert html =~ tenancy_agreement.tenant_name
    end

    test "saves new tenancy_agreement", %{conn: conn} do
      {:ok, index_live, _html} = live(conn, ~p"/tenancy_agreements")

      assert index_live |> element("a", "New Tenancy agreement") |> render_click() =~
               "New Tenancy agreement"

      assert_patch(index_live, ~p"/tenancy_agreements/new")

      assert index_live
             |> form("#tenancy_agreement-form", tenancy_agreement: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert index_live
             |> form("#tenancy_agreement-form", tenancy_agreement: @create_attrs)
             |> render_submit()

      assert_patch(index_live, ~p"/tenancy_agreements")

      html = render(index_live)
      assert html =~ "Tenancy agreement created successfully"
      assert html =~ "some tenant_name"
    end

    test "updates tenancy_agreement in listing", %{conn: conn, tenancy_agreement: tenancy_agreement} do
      {:ok, index_live, _html} = live(conn, ~p"/tenancy_agreements")

      assert index_live |> element("#tenancy_agreements-#{tenancy_agreement.id} a", "Edit") |> render_click() =~
               "Edit Tenancy agreement"

      assert_patch(index_live, ~p"/tenancy_agreements/#{tenancy_agreement}/edit")

      assert index_live
             |> form("#tenancy_agreement-form", tenancy_agreement: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert index_live
             |> form("#tenancy_agreement-form", tenancy_agreement: @update_attrs)
             |> render_submit()

      assert_patch(index_live, ~p"/tenancy_agreements")

      html = render(index_live)
      assert html =~ "Tenancy agreement updated successfully"
      assert html =~ "some updated tenant_name"
    end

    test "deletes tenancy_agreement in listing", %{conn: conn, tenancy_agreement: tenancy_agreement} do
      {:ok, index_live, _html} = live(conn, ~p"/tenancy_agreements")

      assert index_live |> element("#tenancy_agreements-#{tenancy_agreement.id} a", "Delete") |> render_click()
      refute has_element?(index_live, "#tenancy_agreements-#{tenancy_agreement.id}")
    end
  end

  describe "Show" do
    setup [:create_tenancy_agreement]

    test "displays tenancy_agreement", %{conn: conn, tenancy_agreement: tenancy_agreement} do
      {:ok, _show_live, html} = live(conn, ~p"/tenancy_agreements/#{tenancy_agreement}")

      assert html =~ "Show Tenancy agreement"
      assert html =~ tenancy_agreement.tenant_name
    end

    test "updates tenancy_agreement within modal", %{conn: conn, tenancy_agreement: tenancy_agreement} do
      {:ok, show_live, _html} = live(conn, ~p"/tenancy_agreements/#{tenancy_agreement}")

      assert show_live |> element("a", "Edit") |> render_click() =~
               "Edit Tenancy agreement"

      assert_patch(show_live, ~p"/tenancy_agreements/#{tenancy_agreement}/show/edit")

      assert show_live
             |> form("#tenancy_agreement-form", tenancy_agreement: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert show_live
             |> form("#tenancy_agreement-form", tenancy_agreement: @update_attrs)
             |> render_submit()

      assert_patch(show_live, ~p"/tenancy_agreements/#{tenancy_agreement}")

      html = render(show_live)
      assert html =~ "Tenancy agreement updated successfully"
      assert html =~ "some updated tenant_name"
    end
  end
end
