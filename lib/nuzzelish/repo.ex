import Ecto.Query

defmodule Nuzzelish.Repo do
  alias Nuzzelish.{Link, Member, Status, Unfurl}
  use Ecto.Repo,
    otp_app: :nuzzelish,
    adapter: Ecto.Adapters.Postgres

  def get_latest do
    {_, now} = DateTime.now("Etc/UTC")
    a_day_away = DateTime.add(now, 24 * 60 * 60, :second)

    latest = Nuzzelish.Repo.all from l in Link,
      join: m in assoc(l, :members),
      where: l.updated_at < ^a_day_away,
      preload: [members: m]

    # Sort links by descending number of members who shared
    latest |> Enum.sort_by(fn(l) -> length(l.members) end, &>=/2)
  end

  def get_or_set_member(member) do
    member_record = Nuzzelish.Repo.get_by(Member, tw_user_id: member.tw_user_id)

    case member_record do
      nil -> Nuzzelish.Repo.insert!(member)
      _ -> member_record
    end
  end

  def link_member_changeset(link, member_record) do
    link_changeset = Ecto.Changeset.change(link)
    link_changeset |> Ecto.Changeset.put_assoc(:members, [member_record])
  end

  def link_status_changeset(link, status_record) do
    link_changeset = Ecto.Changeset.change(link)
    link_changeset |> Ecto.Changeset.put_assoc(:statuses, [status_record])
  end

  def save_to_db(ds) do
    %{member: member, links: links, status_id: status_id} = ds
    member_record = get_or_set_member(member)
    for link <- links do
      populated = Unfurl.build(link) |> Nuzzelish.Repo.insert!
      status = %Status{tw_status_id: status_id} |> Nuzzelish.Repo.insert!
      populated = Nuzzelish.Repo.preload(populated, [:members, :statuses])
      lm_changeset = link_member_changeset(populated, member_record)
      ls_changeset = link_status_changeset(populated, status)
      Nuzzelish.Repo.update!(lm_changeset)
      Nuzzelish.Repo.update!(ls_changeset)
    end
  end
end
