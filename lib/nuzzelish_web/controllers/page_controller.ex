defmodule NuzzelishWeb.PageController do
  use NuzzelishWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
