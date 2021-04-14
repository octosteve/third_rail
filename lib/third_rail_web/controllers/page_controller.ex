defmodule ThirdRailWeb.PageController do
  use ThirdRailWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
