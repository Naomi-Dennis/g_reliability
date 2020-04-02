defmodule MindTheGapp.Mta do
  alias MindTheGapp.Repo
  alias MindTheGapp.ArrivalTime

  def accept_data(data_source) do
    arrival_times = data_source.()
    Repo.insert_all(ArrivalTime, arrival_times)
  end
end
