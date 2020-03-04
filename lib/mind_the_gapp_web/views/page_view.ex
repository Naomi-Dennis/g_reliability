defmodule MindTheGappWeb.PageView do
  use MindTheGappWeb, :view

  def render("index.json", %{data: data}) do
    %{some_data_more: data, yet_even_more_data: 1000000}
  end
end
