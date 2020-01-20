defmodule Nuzzelish.Repo.Migrations.CreateLinksStatuses do
  use Ecto.Migration

  def change do
    create table(:links_statuses) do
      add :link_id, references(:links)
      add :status_id, references(:statuses)
    end

    create unique_index(:links_statuses, [:link_id, :status_id])
  end
end
