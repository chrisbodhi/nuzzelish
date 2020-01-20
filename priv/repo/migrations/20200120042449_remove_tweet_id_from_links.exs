defmodule Nuzzelish.Repo.Migrations.RemoveTweetIdFromLinks do
  use Ecto.Migration

  def change do
    alter table(:links) do
      remove :tw_status_id
    end
  end
end
