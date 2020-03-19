defmodule MindTheGapp.ArrivalTimeTest do
  use MindTheGapp.DataCase, async: true
  alias MindTheGapp.Mta.ArrivalTime

  setup :create_fake_arrival_time_data

  def create_fake_arrival_time_data(_context) do
    generate_fake_arrival_data()
    :ok
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
  describe "ArrivalTime" do
    test "returns current day to seventh day before" do
      query_results = ArrivalTime.difference_in_arrival_times
      current_day = query_results |> hd |> hd
      last_day = query_results |> Enum.take(-1) |> hd |> hd
      number_of_days_retrieved = (DateTime.diff(current_day, last_day) / (3600 * 24)) |> Kernel.trunc
      assert number_of_days_retrieved == 7
    end

    test "returns at most eight rows, if more than eight rows are available" do
      all_rows =  MindTheGapp.Repo.all(MindTheGapp.ArrivalTime)
      max_number_of_allowed_rows = 8
      arrival_time_data = ArrivalTime.difference_in_arrival_times()
      assert length(arrival_time_data) < length(all_rows)
      assert length(arrival_time_data) <= max_number_of_allowed_rows
    end

    test "returns rows in descending order from current day to earliest day" do
      query_results = ArrivalTime.difference_in_arrival_times
      sorted_rows = query_results  |> Enum.sort(&(&1 >= &2))
      assert query_results == sorted_rows
    end

    test "returns dates in UTC" do
      query_results = ArrivalTime.difference_in_arrival_times
      current_day = query_results |> hd |> hd
      assert current_day.time_zone == "Etc/UTC"
    end

    test "returns averages as floats" do
      query_results = ArrivalTime.difference_in_arrival_times
      current_day_avg_difference = query_results |> hd |> List.last
      assert is_float(current_day_avg_difference)
    end
  end
end
