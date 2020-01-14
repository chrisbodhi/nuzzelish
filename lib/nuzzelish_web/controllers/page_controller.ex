defmodule NuzzelishWeb.PageController do
  use NuzzelishWeb, :controller

  def index(conn, _params) do
    urls = Nuzzelish.Repo.get_latest
    render(conn, "index.html", urls: urls)
  end
end
