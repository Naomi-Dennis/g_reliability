defmodule MindTheGapp.Mta.ScheduledArrivalTime do
  alias MindTheGapp.Repo
  alias MindTheGapp.ScheduledArrivalTime
  alias MindTheGapp.ScheduledArrivalTime, as: ScheduledArrivalTimeSchema

  def is_data_loaded?() do
    !(Repo.all(ScheduledArrivalTimeSchema) |> Enum.empty?)
  end

  def insert_stop_time_from_file(file_name) do
    stop_time_file = get_stop_time_data_from(file_name)
    persist_stop_time_data_from(stop_time_file)
    File.close(stop_time_file)
  end

  defp persist_stop_time_data_from(stop_time_file) do
    case stop_time_file do
      {:ok, stop_times} ->
        stop_times |> Enum.map(fn time -> parse_raw_stop_time(time) |> Repo.insert! end )
      {:error, message} ->
        message |> IO.inspect
    end
  end

  defp get_stop_time_data_from(file_name) do
    File.open(file_name, [:read],
      fn file ->
        lines = IO.read(file, :all)
                |> String.trim_trailing("\n")
                |> String.split("\n")
                |> Enum.filter(fn l -> l |> String.contains?("G24") end)
      end
    )
  end

  defp parse_raw_stop_time(raw_stop_time) do
    separated_data = raw_stop_time |> String.split(",")
    full_trip_id = separated_data |> Enum.fetch!(0)
    arrival_time = separated_data |> Enum.fetch!(1)
    stop_id = separated_data |> Enum.fetch!(3)
    full_trip_id = full_trip_id |> String.split(~r{-|\.}) |> Enum.fetch!(4)
    %ScheduledArrivalTimeSchema{arrival_time: arrival_time, stop_id: stop_id, trip_id: full_trip_id}
  end
end
