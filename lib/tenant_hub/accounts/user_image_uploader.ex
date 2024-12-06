defmodule TenantHub.Accounts.UserImageUploader do
  use Waffle.Definition

  @storage_dir "uploads/users/photos"

  def storage_dir(_version, {_file, user}) do
    Path.join(@storage_dir, "#{user.id}")
  end

  def transform(:original, _file), do: :nochange

  def transform(:thumb, _file) do
    {200, 200}
  end

end
