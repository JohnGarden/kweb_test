defmodule Kyodai.PageController do
  use Kyodai.Web, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end
end
