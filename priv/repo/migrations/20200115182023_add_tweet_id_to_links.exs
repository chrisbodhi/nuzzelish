defmodule Nuzzelish.Repo.Migrations.AddTweetIdToLinks do
  use Ecto.Migration

  def change do
    alter table(:links) do
      add :tw_status_id, :text, null: false, default: "42"
    end
  end
end
