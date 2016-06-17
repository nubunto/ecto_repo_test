defmodule Cards do
  use Application

  def start(_one, _two) do
    import Supervisor.Spec, warn: false

    children = [
      supervisor(Cards.Repo, [])
    ]

    Supervisor.start_link(children, strategy: :one_for_one)
  end
end

defmodule Cards.Repo do
  use Ecto.Repo, otp_app: :cards
end
