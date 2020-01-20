import Ecto.Query

defmodule Nuzzelish.Repo do
  use Ecto.Repo,
    otp_app: :nuzzelish,
    adapter: Ecto.Adapters.Postgres

  def get_latest do
    {_, now} = DateTime.now("Etc/UTC")
    a_day_away = DateTime.add(now, 24 * 60 * 60, :second)

    latest = Nuzzelish.Repo.all from l in Nuzzelish.Link,
      join: m in assoc(l, :members),
      where: l.updated_at < ^a_day_away,
      preload: [members: m]

    # Sort links by descending number of members who shared
    latest |> Enum.sort_by(fn(l) -> length(l.members) end, &>=/2)
  end

  def save_to_db(ds) do
    %{member: member, links: links} = ds
    # todo: what does insert do for existing record?
    member = Nuzzelish.Repo.insert!(member)
    # todo: map over links array, do for each
    links = Nuzzelish.Repo.preload(links, [:members])
    link_changeset = Ecto.Changeset.change(links)
    l_m_changeset = link_changeset |> Ecto.Changeset.put_assoc(:members, [member])
    Nuzzelish.Repo.update!(l_m_changeset)
  end
end
