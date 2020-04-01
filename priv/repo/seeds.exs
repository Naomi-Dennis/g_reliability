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

MtaScheduledArrivalTime.seed()
