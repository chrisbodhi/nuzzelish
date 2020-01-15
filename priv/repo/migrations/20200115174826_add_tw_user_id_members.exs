defmodule Nuzzelish.Repo.Migrations.AddTwUserIdMembers do
  use Ecto.Migration

  def change do
    alter table(:members) do
      add :tw_user_id, :text, null: false, default: "666"
    end
  end
end
