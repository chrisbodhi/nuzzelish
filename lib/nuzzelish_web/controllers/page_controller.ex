defmodule NuzzelishWeb.PageController do
  use NuzzelishWeb, :controller

  def index(conn, _params) do
    urls = Twitter.get_urls()
    render(Map.put(conn, :urls, urls), "index.html")
  end
end
