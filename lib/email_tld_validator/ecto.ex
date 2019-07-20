defmodule EmailTldValidator.Ecto do
  import Ecto.Changeset

  @spec validate_email(changeset :: Ecto.Changeset.t(), field_name :: atom()) ::
          Ecto.Changeset.t()
  def validate_email(changeset, field_name \\ :email)

  def validate_email(%Ecto.Changeset{} = changeset, field_name) when is_atom(field_name) do
    case get_field(changeset, field_name) do
      nil ->
        changeset

      email ->
        if EmailTldValidator.regexp_validate(email) && EmailTldValidator.tld_validate(email) do
          changeset
        else
          add_email_error(changeset, field_name)
        end
    end
  end

  defp add_email_error(changeset, field_name) do
    add_error(changeset, field_name, "is not a valid e-mail address.")
  end
end
