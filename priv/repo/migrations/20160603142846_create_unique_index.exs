defmodule CardsRepository.Repo.Migrations.CreateUniqueIndex do
  use Ecto.Migration

  def change do
    create unique_index(:cards, [:label])
  end
end
