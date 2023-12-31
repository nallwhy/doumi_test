defmodule Doumi.Test.MixProject do
  use Mix.Project

  @source_url "https://github.com/nallwhy/doumi_test"
  @version "0.2.0"

  def project do
    [
      app: :doumi_test,
      version: @version,
      elixir: "~> 1.11",
      elixirc_paths: elixirc_paths(Mix.env()),
      name: "Doumi.Test",
      description: "A helper library that makes it easier to test.",
      deps: deps(),
      package: package(),
      docs: docs()
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger]
    ]
  end

  defp elixirc_paths(:test), do: ["lib", "test/support"]
  defp elixirc_paths(_env), do: ["lib"]

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:decimal, "~> 2.0", optional: true},
      {:ecto, "~> 3.0", optional: true},
      {:ecto_sqlite3, "~> 0.12", optional: true},
      {:ex_doc, "~> 0.30", only: :docs}
    ]
  end

  defp package do
    [
      licenses: ["MIT"],
      maintainers: ["Jinkyou Son(nallwhy@gmail.com)"],
      files: ~w(lib mix.exs README.md LICENSE.md .formatter.exs),
      links: %{"GitHub" => @source_url}
    ]
  end

  defp docs do
    [
      main: "readme",
      source_ref: "v#{@version}",
      source_url: @source_url,
      extras: [
        "README.md": [title: "Overview"],
        "LICENSE.md": [title: "License"]
      ]
    ]
  end
end
