defmodule FakeScheduledStopTimeData do
  def create_fake_stop_time_file(file_name) do
    fake_stop_file = get_fake_data_from_file(file_name)

    case fake_stop_file do
      {:ok, fake_stop_time_data} ->
        fake_stop_time_data

      {:error, message} ->
        message |> IO.inspect()
    end

    File.close(fake_stop_file)
  end

  defp get_fake_data_from_file(file_name) do
    fake_stop_file =
      File.open(file_name, [:write], fn file ->
        fake_raw_stop_times()
        |> Enum.map(fn stop_time_data -> IO.write(file, "#{stop_time_data}\n") end)
      end)
  end

  defp fake_raw_stop_times() do
    [
      "SIR-FA2017-SI017-Sunday-00_027100_SI..N03R,04:54:00,04:52:00,G24,11,,0,0,",
      "SIR-FA2017-SI017-Sunday-01_027100_SI..N03R,10:54:00,04:54:00,G24S,12,,0,0",
      "SIR-FA2017-SI017-Sunday-00_027100_SI..N03R,04:56:00,04:56:00,S23N,13,,0,0,"
    ]
  end
end
