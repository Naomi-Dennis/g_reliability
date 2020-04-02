# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     MindTheGapp.Repo.insert!(%MindTheGapp.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.
defmodule MtaScheduledArrivalTime do
  def seed do
    unless MindTheGapp.Mta.ImportScheduledArrivalTime.is_data_loaded?() do
      MindTheGapp.Mta.ImportScheduledArrivalTime.insert_stop_time_from_file("stop_times.txt")
    end
  end
end

defmodule MtaArrivalTime do
  def seed() do
    starting_date = DateTime.utc_now()

    1..50
    |> Enum.reduce(starting_date, &persist_arrival_time/2)
  end

  defp persist_arrival_time(_x, date_time) do
    actual_time = DateTime.add(date_time, Enum.random(-10..10) * 60)

    %MindTheGapp.ArrivalTime{estimated: date_time, actual: actual_time}
    |> MindTheGapp.Repo.insert!()

    date_time |> DateTime.add(3600 * -6)
  end
end

MtaScheduledArrivalTime.seed()
MtaArrivalTime.seed()
