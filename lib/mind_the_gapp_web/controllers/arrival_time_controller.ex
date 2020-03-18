defmodule MindTheGappWeb.ArrivalTimeController do
  use MindTheGappWeb, :controller
  alias MindTheGapp.Mta.ArrivalTime
  def index(conn, _params) do
    data = ArrivalTime.difference_in_arrival_times()
    render(conn, "index.json",data: data)
  end
end
