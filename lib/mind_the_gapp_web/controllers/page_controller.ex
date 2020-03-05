defmodule MindTheGappWeb.PageController do
  use MindTheGappWeb, :controller

  def index(conn, _params) do
    data = %{some_more_data: 100}
    render(conn, "index.json",data: data)
  end
end
