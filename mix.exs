defmodule Cards.Mixfile do
  use Mix.Project

  def project do
    [app: :cards,
     version: "0.0.1",
     build_path: "../../_build",
     config_path: "../../config/config.exs",
     deps_path: "../../deps",
     lockfile: "../../mix.lock",
     elixir: "~> 1.2",
     build_embedded: Mix.env == :prod,
     start_permanent: Mix.env == :prod,
     aliases: aliases,
     deps: deps]
  end

  def application do
    [mod: {Cards, []},
     applications: [:logger, :postgrex, :ecto]]
  end

  defp deps do
    [{:postgrex, "~> 0.11"},
     {:ecto, ">= 0.0.0"}]
  end

  defp aliases do
    ["ecto.setup": ["ecto.create", "ecto.migrate", "run priv/repo/seeds.exs"],
     "ecto.reset": ["ecto.drop", "ecto.setup"]]
  end
end
