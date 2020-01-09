defmodule Nuzzelish.Repo.Migrations.CreateLinksMembers do
  use Ecto.Migration

  def change do
    create table(:links_members) do
      add :link_id, references(:links)
      add :member_id, references(:members)
    end

    create unique_index(:links_members, [:link_id, :member_id])
  end
end
