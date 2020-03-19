defmodule MindTheGapp.Repo.Migrations.CreateArrivalTimes do
  use Ecto.Migration

  def change do
    create table(:arrival_times) do
      add :estimated, :utc_datetime
      add :actual, :utc_datetime
    end
  end
end
