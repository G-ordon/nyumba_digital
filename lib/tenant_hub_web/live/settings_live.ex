defmodule TenantHubWeb.SettingsLive do
  use TenantHubWeb, :live_view

  @impl true
  def mount(_params, _session, socket) do
    {:ok, assign(socket, :page_title, "User Guide")}
  end

  @impl true
  def render(assigns) do
    ~H"""
    <div class="settings-container">
      <h1><%= @page_title %></h1>
      <p>Welcome to the TenantHub User Guide. This guide provides an in-depth walkthrough of all essential features and functionalities that will help you make the most out of TenantHub. Whether you are a new user or an existing one looking for additional assistance, this guide will cover all the primary steps and processes involved in managing your tenancy online.</p>

      <section>
        <h2>Dashboard Overview</h2>
        <p>Upon logging into TenantHub, you will be taken to the Dashboard. This is the central hub of your account, where you can get an overview of your tenancy information at a glance. The Dashboard provides quick links to important sections like your tenancy agreements, payment history, and account details. The data displayed here includes recent activity and pending actions, helping you stay informed about upcoming payments, expiring agreements, and any messages from your landlord or property manager. This central view helps you keep track of your tenancy obligations efficiently and serves as the starting point for navigating other features.</p>
      </section>

      <section>
        <h2>Managing Tenancy Agreements</h2>
        <p>Your tenancy agreements are stored under the "Agreements" section. Here, you can view all active and past agreements, which detail your rental terms, payment schedules, and key agreement dates, such as start and end dates. Each agreement is listed with specific details that allow you to review your obligations and stay aware of upcoming renewal periods or termination dates. In case of any changes to your agreement, this section will reflect updates made by your property manager. Having easy access to these agreements ensures you have all relevant information about your tenancy terms readily available.</p>
      </section>

      <section>
        <h2>Making Payments</h2>
        <p>TenantHub offers a straightforward method for handling rent and deposit payments. In the "Payments" section, you can securely add a payment method, review your payment history, and initiate new payments. You will receive prompts to confirm payment details, which can include setting up a recurring payment for convenience. The platform allows you to track all completed transactions, providing transparency and a digital trail of your payment history. Keeping this section up-to-date ensures timely payments and helps avoid late fees, while the digital receipts serve as documentation for your financial records.</p>
      </section>

      <section>
        <h2>Updating Account Information</h2>
        <p>Your account information, including your contact details, can be updated under the "Account" tab. Ensuring that your contact information is current is crucial for receiving timely notifications about payments, agreement updates, and landlord messages. This section allows you to manage your email, phone number, and other pertinent details easily. Keeping your information up-to-date also enhances communication and avoids potential issues with missed notifications about payment due dates or agreement changes.</p>
      </section>

      <section>
       <h2>Support</h2>
       <p>
         If you have questions or experience issues while using TenantHub, our support team is here to assist you. For general inquiries or technical support, you can reach us by emailing
         <a href="mailto:gordonochieng5454@gmail.com">gordonochieng5454@gmail.com</a>.
         For immediate answers, please also consider visiting our
      <a href={~p"/faq"}>FAQ section</a>.
     </p>
    </section>

    </div>
     <br>
     <a href="/admin/dashboard" class="back-button">Admin Dashboard</a>
    <a href="/user/dashboard" class="back-button">Back to User's Dashboard</a>
    """
  end
end
