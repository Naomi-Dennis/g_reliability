defmodule MindTheGapp.ScheduledArrivalTimeTest do
  use MindTheGapp.DataCase, async: true
  alias MindTheGapp.Mta.ScheduledArrivalTime
  alias MindTheGapp.Repo
  alias MindTheGapp.ScheduledArrivalTime, as: ScheduledArrivalTimeSchema

  setup do
      stop_time_data_file_name = "fake_time.txt"
      FakeScheduledStopTimeData.create_fake_stop_time_file(stop_time_data_file_name)
      ScheduledArrivalTime.insert_stop_time_from_file(stop_time_data_file_name)
    :ok
  end

  describe "ScheduledArrivalTime" do
    test "insert stop time data from designated file" do
      northbound_arrival_time = %ScheduledArrivalTimeSchema{arrival_time: "04:54:00", stop_id: "G24", trip_id: "00_027100_SI"}
      southbound_arrival_time =  %ScheduledArrivalTimeSchema{arrival_time: "10:54:00", stop_id: "G24S", trip_id: "01_027100_SI"}
      assert database_contains_arrival_time?(northbound_arrival_time)
      assert database_contains_arrival_time?(southbound_arrival_time)
    end

    test "only contains stop time data for G24 stops" do
      unexpected_arrival_time = %ScheduledArrivalTimeSchema{arrival_time: "04:56:00", stop_id: "S23N", trip_id: "00_027100_SI"}
      refute database_contains_arrival_time?(unexpected_arrival_time)
    end

    test "returns true if stop time data if data is present" do
      assert ScheduledArrivalTime.is_data_loaded?()
    end

    test "returns false  stop time data if data is not present" do
      Repo.delete_all(ScheduledArrivalTimeSchema)
      refute ScheduledArrivalTime.is_data_loaded?()
    end

    def database_contains_arrival_time?(train) do
      Repo.exists?(from s in ScheduledArrivalTimeSchema,
                   where: s.stop_id == ^train.stop_id and s.arrival_time == ^train.arrival_time and s.trip_id == ^train.trip_id)
    end
  end
end
