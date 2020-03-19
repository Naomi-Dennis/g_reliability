defmodule MindTheGapp.ArrivalTime do
  use Ecto.Schema
  alias MindTheGapp.Repo
  schema "arrival_times" do
    field :estimated, :utc_datetime_usec
    field :actual, :utc_datetime_usec
  end
end
