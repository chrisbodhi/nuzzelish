defmodule Nuzzelish.Link do
  use Ecto.Schema
  import Ecto.Changeset

  schema "links" do
    field :description, :string
    field :image, :string
    field :site_name, :string
    field :title, :string
    field :url, :string
    many_to_many :members, Nuzzelish.Member, join_through: "links_members"

    timestamps()
  end

  @doc false
  def changeset(link, attrs) do
    link
    |> cast(attrs, [:url, :title, :description, :site_name, :image])
    |> validate_required([:url, :title, :description, :site_name, :image])
  end
end
