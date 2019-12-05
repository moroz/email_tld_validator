defmodule EmailTldValidator.MixProject do
  use Mix.Project

  def project do
    [
      app: :email_tld_validator,
      version: "0.1.1",
      elixir: "~> 1.9",
      start_permanent: Mix.env() == :prod,
      deps: deps(),
      package: package(),
      description: description(),

      # Docs
      name: "EmailTldValidator",
      source_url: "https://gitlab.com/moroz2137/email_tld_validator",
      docs: [
        main: "readme",
        extras: ["README.md"]
      ]
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    []
  end

  def description do
    """
    A simple email address validator for Elixir that first checks the address with a regular
    expression and then checks if the Top-Level Domain of the host is included in ICANN's
    List of Top-Level Domains.
    The package is meant for use with `Ecto.Changeset`.
    """
  end

  def package do
    [
      maintainers: ["Karol Moroz <k.j.moroz@gmail.com>"],
      licenses: ["MIT"],
      links: %{
        "GitLab" => "https://gitlab.com/moroz2137/email_tld_validator"
      }
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:ecto, ">= 2.0.0"},

      # Docs
      {:ex_doc, "~> 0.19", only: :dev, runtime: false}
    ]
  end
end
