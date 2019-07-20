# EmailTldValidator

A simple email address validator for Elixir that first checks the address with a regular
expression and then checks if the Top-Level Domain of the host is included in ICANN's
[List of Top-Level Domains](https://www.icann.org/resources/pages/tlds-2012-02-25-en).
The package is meant for use with `Ecto.Changeset`.

## Installation

If [available in Hex](https://hex.pm/docs/publish), the package can be installed
by adding `email_tld_validator` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [
    {:email_tld_validator, "~> 0.1.0"}
  ]
end
```

## Usage

The features of this library are split into two modules: `EmailTldValidator` and
`EmailTldValidator.Ecto`.

To just check if an e-mail is valid outside of an `Ecto.Changeset`, use `EmailTldValidator/1`:

```elixir
EmailTldValidator.email_valid?("user@example.com")
# => true

EmailTldValidator.email_valid?("user@example")
# => false (does not match the regular expression)

EmailTldValidator.email_valid?("user@example.foobar")
# => false (non-existent TLD)
```
