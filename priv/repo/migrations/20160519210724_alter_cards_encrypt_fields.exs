defmodule CardsRepository.Repo.Migrations.AlterCardsEncryptFields do
  use Ecto.Migration

  def change do
    alter table(:cards) do
      remove :trilha_1
      remove :trilha_2

      add :trilha_1, :binary
      add :trilha_2, :binary
    end
  end
end
