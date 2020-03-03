defmodule MindTheGappWeb.PageView do
  use MindTheGappWeb, :view

  def render("index.json", %{data: data}) do
    %{some_data_more: data}
  end
end
