defmodule CardsRepository.Repo.Migrations.CreateExtensionPgtrgm do
  use Ecto.Migration

  def up do
   execute "CREATE extension if not exists pg_trgm;"
  end
end
