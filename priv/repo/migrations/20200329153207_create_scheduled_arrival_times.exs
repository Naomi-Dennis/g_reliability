defmodule MindTheGapp.Repo.Migrations.CreateScheduledArrivalTimes do
  use Ecto.Migration

  def change do
    create table(:scheduled_arrival_times) do
      add :trip_id, :string
      add :arrival_time, :string
      add :stop_id, :string
    end

  end
end
