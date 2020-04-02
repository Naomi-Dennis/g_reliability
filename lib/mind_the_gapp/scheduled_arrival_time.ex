defmodule MindTheGapp.ScheduledArrivalTime do
  use Ecto.Schema
  alias MindTheGapp.Repo

  schema "scheduled_arrival_times" do
    field :trip_id, :string
    field :arrival_time, :string
    field :stop_id, :string
  end
end
