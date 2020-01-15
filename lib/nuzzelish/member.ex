defmodule Nuzzelish.Member do
  use Ecto.Schema
  import Ecto.Changeset

  schema "members" do
    field :avatar_url, :string
    field :screen_name, :string
    field :tw_user_id, :string
    many_to_many :links, Nuzzelish.Link, join_through: "links_members"

    timestamps()
  end

  @doc false
  def changeset(member, attrs) do
    member
    |> cast(attrs, [:screen_name, :avatar_url])
    |> validate_required([:screen_name, :avatar_url])
  end
end
