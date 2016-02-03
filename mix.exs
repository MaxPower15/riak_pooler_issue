defmodule RiakPoolerIssue.Mixfile do
  use Mix.Project

  def project do
    [app: :riak_pooler_issue,
     version: "0.0.1",
     elixir: "~> 1.2",
     build_embedded: Mix.env == :prod,
     start_permanent: Mix.env == :prod,
     deps: deps]
  end

  # Configuration for the OTP application
  #
  # Type "mix help compile.app" for more information
  def application do
    [applications: [:logger, :riak]]
  end

  # Dependencies can be Hex packages:
  #
  #   {:mydep, "~> 0.3.0"}
  #
  # Or git/path repositories:
  #
  #   {:mydep, git: "https://github.com/elixir-lang/mydep.git", tag: "0.1.0"}
  #
  # Type "mix help deps" for more examples and options
  defp deps do
    [
      # Riak elixir library (wraps official riakc lib)
      {:riak, github: "drewkerrigan/riak-elixir-client", tag: "7be582e740db8d6f1e44c42383e0a4fbbd2ed848"},
    ]
  end
end
