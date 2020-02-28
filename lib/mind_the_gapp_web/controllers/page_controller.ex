defmodule MindTheGappWeb.PageController do
  use MindTheGappWeb, :controller

  def index(conn, _params) do
    data = %{some_data: 1}
    render(conn, "index.json",data: data)
  end
end
