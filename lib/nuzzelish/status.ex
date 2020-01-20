defmodule Nuzzelish.Status do
  use Ecto.Schema
  import Ecto.Changeset

  schema "statuses" do
    field :tw_status_id, :string
    many_to_many :links, Nuzzelish.Link, join_through: "links_statuses"

    timestamps()
  end

  @doc false
  def changeset(member, attrs) do
    member
    |> cast(attrs, [:tw_status_id])
    |> validate_required([:tw_status_id])
  end
end
