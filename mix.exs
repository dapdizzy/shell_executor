defmodule ShellExecutor.Mixfile do
  use Mix.Project

  def project do
    [
      app: :shell_executor,
      version: "0.1.5",
      elixir: "~> 1.5",
      start_permanent: Mix.env == :prod,
      deps: deps(),
      description: description(),
      package: package(),
      name: "ShellExecutor"
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
      {:ex_doc, ">= 0.0.0", only: :dev}
      # {:dep_from_hexpm, "~> 0.3.0"},
      # {:dep_from_git, git: "https://github.com/elixir-lang/my_dep.git", tag: "0.1.0"},
    ]
  end

  defp description do
    "This is a GenServer-ish implementation RabbitMQ Receiver."
  end

  defp files do
    ["lib", "mix.exs"]
  end

  defp package do
    [
      name: "shell_executor",
      maintainers: ["Dmitry A. Pyatkov"],
      licenses: ["Apache 2.0"],
      files: files(),
      links: %{"Hex Docs" => "https://hexdocs.pm"}
    ]
  end
end
