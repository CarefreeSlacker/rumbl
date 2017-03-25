defmodule Rumbl.PageController do
  use Rumbl.Web, :controller

  # plug :action

  def index(conn, _params) do
    render conn, "index.html"
  end
end
