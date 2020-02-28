defmodule MindTheGappWeb.PageView do
  use MindTheGappWeb, :view

  def render("index.json", %{data: data}) do
    %{some_data: data}
  end
end
