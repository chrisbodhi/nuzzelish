defmodule NuzzelishWeb.PageController do
  use NuzzelishWeb, :controller

  def index(conn, _params) do
    urls = Nuzzelish.Repo.get_latest
    render(Map.put(conn, :urls, urls), "index.html")
  end
end
