defmodule TenantHubWeb.FaqLive do
  use TenantHubWeb, :live_view

   # defining the faqs's here
  @faqs [
    %{id: 1, question: "What is TenantHub?", answer: "TenantHub is a platform designed for tenants and property owners to manage rental agreements, payments, and communication seamlessly.", visible: false},
    %{id: 2, question: "How do I create an account on TenantHub?", answer: "You can create an account by clicking on the \"Register\" button on the homepage. Provide your email, password, and other necessary details to sign up.", visible: false},
    %{id: 3, question: "Can I manage multiple properties on TenantHub?", answer: "Yes, TenantHub supports property owners and landlords who can manage multiple properties under their account.", visible: false},
    %{id: 4, question: "How do I pay my rent through TenantHub?", answer: "Once logged in, navigate to the “Payments” section. You can securely make payments directly through the platform using various payment methods.", visible: false},
    %{id: 5, question: "What should I do if I forget my password?", answer: "Click on the \"Forgot Password\" link on the login page. Enter your registered email address, and we will send you a password reset link.", visible: false},
    %{id: 6, question: "How can I contact customer support?", answer: "If you need help, visit our \"Support\" page and submit a request or contact us through email at gordonochieng5454@gmail.com.", visible: false},
    %{id: 7, question: "Is TenantHub available for both landlords and tenants?", answer: "Yes, TenantHub is designed to be user-friendly for both tenants and landlords. Tenants can view and pay rent, while landlords can manage property listings, leases, and payments.", visible: false},
    %{id: 8, question: "Can I access TenantHub from my phone?", answer: "Yes, TenantHub is fully mobile-responsive, allowing you to access your account from any smartphone or tablet.", visible: false},
    %{id: 9, question: "Are my data and payment details secure?", answer: "Yes, TenantHub employs the latest encryption technologies to ensure that your personal and payment information is fully secure.", visible: false},
    %{id: 10, question: "How do I log out of my account?", answer: "Click on the profile icon in the top right corner of your dashboard and select \"Log out\" to securely sign out of your account.", visible: false}
  ]

  def mount(_params, _session, socket) do
    {:ok, assign(socket, faqs: @faqs)}
  end


  def handle_event("toggle_answer", %{"id" => id}, socket) do
    faqs = Enum.map(socket.assigns.faqs, fn faq ->
      if faq.id == String.to_integer(id) do
        %{faq | visible: !faq.visible}
      else
        faq
      end
    end)

    {:noreply, assign(socket, faqs: faqs)}
  end

end
