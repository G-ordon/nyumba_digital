defmodule TenantHubWeb.TenancyAgreementLive.FormComponent do
  use TenantHubWeb, :live_component

  alias TenantHub.Tenancies

  @impl true
  def render(assigns) do
    IO.inspect(assigns.form_submitted, label: "Form Submitted")

    ~H"""
    <div>
      <.header>
        <%= @title %>
        <:subtitle>Use this form to manage tenancy agreement records in your database.</:subtitle>
      </.header>

      <.simple_form
        for={@form}
        id="tenancy_agreement-form"
        phx-target={@myself}
        phx-change="validate"
        phx-submit="save"
      >
        <h2>Tenancy Agreement</h2>
        <p>
          This Tenancy Agreement is made and entered into between Pollet Obuya ("Landlord") and
          <u><%= @form[:tenant_name].value || "________________" %></u> ("Tenant") and outlines the terms and conditions governing the rental of the premises by the Tenant from the Landlord.
        </p>

        <h3><strong>1. Landlord Information</strong></h3>
        <p>Name: Pollet Obuya</p>

        <h3><strong>2. Tenant Information</strong></h3>
        <.input field={@form[:tenant_name]} type="text" label="Tenant Name" placeholder="Fill in tenant's name here" />
        <.input field={@form[:tenant_address]} type="text" label="Tenant Address" />
        <.input field={@form[:tenant_phone]} type="text" label="Tenant Phone" />
        <.input field={@form[:agreement_content]} label="Agreement Content" />


        <h3><strong>3. Tenancy Details</strong></h3>
        <p>This tenancy agreement establishes that the Tenant is permitted to occupy the specified rental property. The Tenant agrees to comply with the terms set forth in this agreement during the period of occupancy.</p>

        <h3><strong>4. Rent</strong></h3>
        <.input field={@form[:rent]} type="number" label="Monthly Rent Amount" step="any" />
        <p>
          The tenant shall pay the landlord a rent of Kenya Shilling 4500 per month in advance, the first of such monthly payments being due and payable on tenancy commencement date, and thereafter every payment in respect of rent shall be due on the 10th of every month.
          The rent herein above shall be reviewed from time to time by the Landlady in consultation with the tenant.
          All payments in respect to house rent shall be made payable to <strong>MPESA TILL NUMBER 4154742</strong>. The rent payable will be inclusive of water bills and Wi-Fi charges but exclusive of accruing electricity bills.
        </p>
        <.input field={@form[:late_fee]} type="text" label="Late Fee (optional)" placeholder="Specify late fee details" />

        <h3><strong>5. Security Deposit</strong></h3>
        <.input field={@form[:deposit]} type="number" label="Deposit Amount" step="any" />
        <p>
          Use of Deposit: The security deposit will be held by the Landlord and refunded upon termination of the tenancy, provided the premises are left in good condition and there are no outstanding fees, damages, or unpaid rent.
        </p>

        <h3><strong>6. Occupancy</strong></h3>
        <p>
          a. The property is designated for 'single person' and student occupancy only. Family members, married couples, or unrelated adults other than the Tenant are not permitted to occupy the property.
        </p>
        <p>
          b. The tenant shall physically operate in the premises at all times and shall not at any time assign or sub-let any part of the possession thereof without prior written consent of the Landlady.
        </p>

        <h3><strong>7. Maintenance and Cleanliness</strong></h3>
        <p>
          a. The Tenant is responsible for keeping the premises in a clean, sanitary condition. The Tenant agrees to notify the Landlord promptly of any necessary repairs.
        </p>
        <p>
          b. The Tenant shall be responsible for all damages which are incurred as a result of negligence or willful act on the part of the Tenant and shall repair the same at his/her own expenses if required to do so by the Landlady or caretaker.
        </p>
        <p>
          c. The tenant shall keep the premises in good condition and order and shall meet all the repair costs other than those resulting from natural wear and tear.
        </p>

        <h3><strong>8. Morals</strong></h3>
        <p>
          a. The Tenant agrees to conduct themselves in a respectful manner. Behavior that causes disturbance to other tenants, neighbors, or the Landlord is prohibited.
        </p>
        <p>
          b. The tenant shall use the premises only for its official purposes and shall not in any way carry out trade contrary and/or sell liquor or anything spirituous therein.
        </p>
        <p>
          c. The tenant shall not store in the premises any goods, merchandise, or explosives of dangerous nature whatsoever.
        </p>
        <p>
          d. The tenant shall not conduct him/herself and/or play any musical instruments to the annoyance of the neighbors to such an extent as to cause a general nuisance.
        </p>

        <h3><strong>9. Inspections</strong></h3>
        <p>
          The caretaker reserves the right to inspect the property on a quarterly basis, with 24 hours’ notice. The Landlady shall, at all reasonable times upon notifying the Tenant, be entitled to enter the premises to inspect the state of cleanliness and all repairs or carry out any work necessary for the proper upkeep of the premises.
        </p>

        <h3><strong>10. Unauthorized Structures</strong></h3>
        <p>
          The Tenant is not permitted to make alterations and additions to the property without prior approval from the Landlord, nor erect or cause to be erected any structure in the premises or in the surrounding areas.
        </p>

        <h3><strong>11. Termination of Tenancy</strong></h3>
        <p>
          Notice Requirement: If rent shall at any time during the period of the tenancy become more than 14 days in arrears, or if the tenant shall omit to perform or observe any of the covenants herein, the Landlady and her authorized agents shall retain the right to terminate the tenancy and assume possession of the premises immediately and take whatever action they think fit to recover arrears thereof, provided that the Landlady will give the tenant a 7-day notice of the breach.
        </p>

        <h3><strong>12. In Witness of Parties</strong></h3>
        <p>
          This agreement is acknowledged by Caretaker, who serves as a witness to the Landlord and Tenant’s agreement.
        </p>

        <h3><strong>13. Tenant Acknowledgment</strong></h3>
        <p>
          By signing this agreement, the Tenant acknowledges that they have read, understood, and agree to the terms and conditions outlined in this tenancy agreement.
        </p>

        <.input field={@form[:signature]} type="text" label="Tenant's Name (Signature)" />
        <.input field={@form[:start_date]} type="date" label="Start Date" />
        <.input field={@form[:end_date]} type="date" label="End Date" />

        <:actions>
          <.button phx-disable-with="Saving...">Submit Tenancy Agreement</.button>
        </:actions>
      </.simple_form>

      <%= if @form_submitted do %>
        <div class="alert alert-success mt-4">
          Form submitted successfully!
        </div>
      <% end %>
    </div>
    """
  end

  @impl true
  def update(%{tenancy_agreement: tenancy_agreement} = assigns, socket) do
    {:ok,
     socket
     |> assign(assigns)
     |> assign_new(:form, fn ->
       to_form(Tenancies.change_tenancy_agreement(tenancy_agreement))
     end)
     |> assign(:form_submitted, false)}  # Default state for form submission
  end

  @impl true
  def handle_event("validate", %{"tenancy_agreement" => tenancy_agreement_params}, socket) do
    IO.inspect(tenancy_agreement_params, label: "Form Data")  # Debugging line
    changeset = Tenancies.change_tenancy_agreement(socket.assigns.tenancy_agreement, tenancy_agreement_params)
    {:noreply, assign(socket, form: to_form(changeset, action: :validate))}
  end

  def handle_event("save", %{"tenancy_agreement" => tenancy_agreement_params}, socket) do
    IO.inspect(tenancy_agreement_params, label: "Saving Form Data")  # Debugging line

    # Make sure user_id is set
    updated_params = Map.put(tenancy_agreement_params, "user_id", socket.assigns.current_user.id)

    case Tenancies.create_tenancy_agreement(updated_params) do
      {:ok, _tenancy_agreement} ->
        {:noreply, assign(socket, form_submitted: true)}
      {:error, changeset} ->
        IO.inspect(changeset, label: "Error in Creating Tenancy Agreement")  # Debugging line
        {:noreply, assign(socket, form: to_form(changeset, action: :save))}
    end
  end

end
