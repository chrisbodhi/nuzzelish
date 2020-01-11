import Ecto.Query

defmodule Nuzzelish.Repo do
  use Ecto.Repo,
    otp_app: :nuzzelish,
    adapter: Ecto.Adapters.Postgres

  def get_latest do
    Nuzzelish.Repo.all from l in Nuzzelish.Link,
      join: m in assoc(l, :members),
      preload: [members: m]
  end
end
