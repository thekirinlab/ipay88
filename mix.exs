defmodule IPay88.MixProject do
  use Mix.Project

  def project do
    [
      app: :ipay88,
      version: "0.1.2",
      elixir: "~> 1.7",
      start_permanent: Mix.env() == :prod,
      deps: deps(),
      description: description(),
      package: package()
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger]
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:jason, "~> 1.1"},
      {:httpoison, "~> 1.0"},
      {:ex_doc, "~> 0.18", only: :dev}
    ]
  end

  defp description do
    """
    A Elixir client for iPay88 payment gateway.
    """
  end

  defp package do
    [
      files: ["lib", "mix.exs", "README*", "LICENSE*"],
      maintainers: ["Vu Minh Tan"],
      licenses: ["Apache 2.0"],
      links: %{"GitHub" => "https://github.com/thekirinlab/ipay88"}
    ]
  end
end
