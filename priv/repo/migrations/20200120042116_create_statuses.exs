defmodule Nuzzelish.Repo.Migrations.CreateStatuses do
  use Ecto.Migration

  def change do
    create table(:statuses) do
      add :tw_status_id, :string

      timestamps()
    end
  end
end
