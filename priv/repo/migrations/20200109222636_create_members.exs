defmodule Nuzzelish.Repo.Migrations.CreateMembers do
  use Ecto.Migration

  def change do
    create table(:members) do
      add :screen_name, :string
      add :avatar_url, :string

      timestamps()
    end

  end
end
