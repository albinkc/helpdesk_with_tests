defmodule Helpdesk.MixProject do
  use Mix.Project

  def project do
    [
      app: :helpdesk,
      version: "0.1.0",
      elixir: "~> 1.16",
      start_permanent: Mix.env() == :prod,
      deps: deps()
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger],
      mod: {Helpdesk.Application, []}
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:ash, github: "ash-project/ash", branch: "main", override: true},
      {:picosat_elixir, "~> 0.2"},
      {:ash_postgres, github: "ash-project/ash_postgres", branch: "main", override: true}
    ]
  end
end
