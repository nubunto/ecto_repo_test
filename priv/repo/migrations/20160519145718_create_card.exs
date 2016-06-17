defmodule CardsRepository.Repo.Migrations.CreateCard do
  use Ecto.Migration

  def change do
    create table(:cards) do
      add :label, :string
      add :comentario, :string
      add :trilha_2, :string
      add :trilha_1, :string
      add :cod_seguranca, :string
      add :senha, :string
      add :trilha1_5dig, :string
      add :pan, :string

      timestamps
    end

  end
end
