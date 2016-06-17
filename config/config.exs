use Mix.Config

config :cards, Cards.Encryption.AES,
  key: :base64.decode("RUdoR1NxS0VyMkN2cXdhcg==")

config :cards, ecto_repos: [Cards.Repo]

config :cards, Cards.Repo,
  adapter: Ecto.Adapters.Postgres,
  username: "postgres",
  password: "pl099..AA",
  database: "cards_repository_dev",
  hostname: "localhost",
  pool_size: 10
