defmodule Nuzzelish.Repo.Migrations.CreateStatuses do
  use Ecto.Migration

  def change do
    create table(:statuses) do
      add :tw_status_id, :text

      timestamps()
    end
  end
end
