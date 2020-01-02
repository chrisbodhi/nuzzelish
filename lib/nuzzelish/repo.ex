defmodule Nuzzelish.Repo do
  use Ecto.Repo,
    otp_app: :nuzzelish,
    adapter: Ecto.Adapters.Postgres
end
