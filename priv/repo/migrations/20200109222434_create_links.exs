defmodule Nuzzelish.Repo.Migrations.CreateLinks do
  use Ecto.Migration

  def change do
    create table(:links) do
      add :url, :string
      add :title, :string
      add :description, :string
      add :site_name, :string
      add :image, :string

      timestamps()
    end

  end
end
