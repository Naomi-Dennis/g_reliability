defmodule MindTheGapp.Mta.DatasourceParser do
  def parse(map) do
    map
    |> Enum.map(fn entity ->
      case is_nil(entity.trip_update) do
      true ->
        []
      false ->
        trip_id = parse_trip_id(entity.trip_update)
        parse_stop_time_data(trip_id, entity.trip_update)
      end
    end) |> List.flatten
  end

  defp parse_trip_id(trip_update_data) do
    trip_update_data.trip.trip_id
  end

  defp parse_stop_time_data(trip_id, trip_update_data) do
    stop_time_data = trip_update_data.stop_time_update
    stop_time_data |> Enum.map(fn stop_time ->
      %{trip_id: trip_id, stop_id: stop_time.stop_id, arrival: stop_time.arrival.time}
    end)
  end

end
