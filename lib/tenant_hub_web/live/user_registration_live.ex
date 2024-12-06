defmodule TenantHubWeb.UserRegistrationLive do
  use TenantHubWeb, :live_view

  alias TenantHub.Accounts
  alias TenantHub.Accounts.User

  def render(assigns) do
    ~H"""
    <div class="mx-auto max-w-sm">
      <.header class="text-center">
        Register for an account
        <:subtitle>
          Already registered?
          <.link navigate={~p"/users/log_in"} class="font-semibold text-brand hover:underline">
            Log in
          </.link>
          to your account now.
        </:subtitle>
      </.header>

      <.simple_form
        for={@form}
        id="registration_form"
        phx-submit="save"
        phx-change="validate"
        action={~p"/users/log_in?_action=registered"}
        method="post"
        enctype="multipart/form-data"
      >
        <.error :if={@check_errors}>
          Oops, something went wrong! Please check the errors below.
        </.error>

        <.input field={@form[:email]} type="email" label="Email" required />
        <.input field={@form[:password]} type="password" label="Password" required />

        <div>
          <label for="user_role">Select Role</label>
          <select name="user[role]" id="user_role" required>
            <option value="">Select Role</option>
            <option value="tenant">Tenant</option>
            <option value="admin">Admin</option>
          </select>
        </div>

        <.input field={@form[:full_names]} type="text" label="Full Names" required />
        <.input field={@form[:postal_address]} type="text" label="Postal Address" required />
        <.input field={@form[:telephone_number]} type="text" label="Telephone Number" required />
        <.input field={@form[:nationality]} type="text" label="Nationality" required />
        <.input field={@form[:identification_number]} type="text" label="ID Number" required />
        <.input field={@form[:organization]} type="text" label="Organization" required />
        <.input field={@form[:next_of_kin]} type="text" label="Next of Kin" required />
        <.input field={@form[:next_of_kin_contact]} type="text" label="Next of Kin Contact" required />
        <.input field={@form[:photo]} type="file" label="Photo" />

        <:actions>
          <.button phx-disable-with="Creating account..." class="w-full">Create an account</.button>
        </:actions>
      </.simple_form>
    </div>
    """
  end

  def mount(_params, _session, socket) do
    changeset = Accounts.change_user_registration(%User{})
    {:ok, assign(socket, trigger_submit: false, check_errors: false, form: to_form(changeset, as: "user"))}
  end
  def handle_event("save", %{"user" => user_params}, socket) do
    # Handle file upload
    user_params = handle_file_upload(user_params)

    case Accounts.register_user(user_params) do
      {:ok, _user} ->
        socket =
          socket
          |> put_flash(:info, "User registered successfully! You can now log in to access your profile.")
          |> redirect(to: ~p"/users/log_in")

        {:noreply, socket}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, check_errors: true, form: to_form(changeset, as: "user"))}
    end
  end

  def handle_event("validate", %{"user" => user_params}, socket) do
    changeset = Accounts.change_user_registration(%User{}, user_params)
    {:noreply, assign(socket, form: to_form(changeset, as: "user"))}
  end

  # Helper function to handle file uploads
  defp handle_file_upload(user_params) do
    case Map.fetch(user_params, "photo") do
      {:ok, %Plug.Upload{path: path}} ->
        # Process file upload if it exists
        Map.put(user_params, "photo", path)

      _ ->
        # If no file is uploaded, return the user_params as is
        user_params
    end
  end
end
