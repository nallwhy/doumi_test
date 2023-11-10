defmodule Doumi.Test.MixProject do
  use Mix.Project

  @source_url "https://github.com/nallwhy/doumi_test"
  @version "0.1.0"

  def project do
    [
      app: :doumi_test,
      version: @version,
      elixir: "~> 1.11",
      name: "Doumi.Test",
      description: "A helper library that makes it easier to test.",
      deps: deps(),
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
      {:decimal, "~> 2.0", optional: true},
      {:ecto, "~> 3.0", only: :test}
    ]
  end

  defp package do
    [
      licenses: ["MIT"],
      maintainers: ["Jinkyou Son(nallwhy@gmail.com)"],
      files: ~w(lib mix.exs README.md LICENSE.md),
      links: %{"GitHub" => @source_url}
    ]
  end
end
