defmodule CardsRepository.Repo.Migrations.CardsAddPanMask do
  use Ecto.Migration

  def change do
    alter table(:cards) do
      add :pan_mask, :string
    end
  end
end
