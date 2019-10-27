defmodule IdenticonGenerator.MixProject do
  use Mix.Project

  def project do
    [
      app: :identicon_generator,
      version: "0.1.0",
      elixir: "~> 1.9",
      start_permanent: Mix.env() == :prod,
      deps: deps()
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger, :runtime_tools],
      mod: {IdenticonGenerator.Application, []}
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      # {:dep_from_hexpm, "~> 0.3.0"},
      # {:dep_from_git, git: "https://github.com/elixir-lang/my_dep.git", tag: "0.1.0"}
      {:poison, "~> 3.1"},
      {:plug_cowboy, "~> 2.0"},
      {:cowboy, "~> 2.7"},
      {:ex_doc, "~> 0.21.1"},
      {:egd, github: "erlang/egd"}
    ]
  end
end
