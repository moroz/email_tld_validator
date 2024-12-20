defmodule EmailTldValidator do
  @email_regex ~r/^(([^<>()\[\]\\.,;:\s@"]+(\.[^<>()\[\]\\.,;:\s@"]+)*)|(".+"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$/

  priv_dir = :code.priv_dir(:email_tld_validator)
  domain_file = Path.join(priv_dir, "tlds-alpha-by-domain.txt")
  @compile :no_native
  @external_resource domain_file
  stream = File.stream!(domain_file)

  domains =
    for line <- stream,
        not String.starts_with?(line, ["#", "\n"]),
        do: line |> String.trim() |> String.downcase()

  for domain <- domains do
    def tld_valid?(unquote(domain)), do: true
  end

  def tld_valid?(_), do: false

  @doc """
  Checks whether an email address matches a reasonably comprehensive regular expression
  and whether the TLD (Top-Level Domain) included in the hostname part of the address is included in the
  [IANA alphabetic list of TLDs](https://data.iana.org/TLD/tlds-alpha-by-domain.txt).

  ## Examples

      iex> EmailTldValidator.email_valid?("user@example.com")
      true

      iex> EmailTldValidator.email_valid?("user@example")
      false

      iex> EmailTldValidator.email_valid?("user@example.foobar")
      false

  """
  def email_valid?(email) do
    regexp_validate(email) && tld_validate(email)
  end

  def tld_validate(email) do
    email
    |> String.trim()
    |> String.split(".")
    |> List.last()
    |> String.downcase()
    |> tld_valid?()
  end

  def regexp_validate(email), do: Regex.match?(@email_regex, String.trim(email))
end
