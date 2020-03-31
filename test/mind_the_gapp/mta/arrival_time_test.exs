defmodule MindTheGapp.Mta.ArrivalTimeTest do
  use MindTheGapp.DataCase, async: true
  alias MindTheGapp.Mta.ArrivalTime

  setup do
    FakeArrivalTimes.create_fake_arrival_time_data()
    :ok
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
