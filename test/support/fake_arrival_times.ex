defmodule FakeArrivalTimes do
  alias MindTheGapp.Mta.ArrivalTime

  def create_fake_arrival_time_data() do
    generate_fake_arrival_data()
  end

  def generate_fake_arrival_data() do
    starting_date = DateTime.utc_now

     1..50
     |> Enum.reduce(starting_date, &persist_arrival_time/2)
  end

  def persist_arrival_time(_x, date_time) do
    actual_time = DateTime.add(date_time, Enum.random(-10..10) * 60)

     %MindTheGapp.ArrivalTime{estimated: date_time, actual: actual_time}
     |> MindTheGapp.Repo.insert!()

    date_time |> DateTime.add(3600 * -6)
  end
end
