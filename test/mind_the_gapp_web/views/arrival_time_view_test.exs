defmodule MindTheGappWeb.ArrivalTimeViewTest do
  use MindTheGappWeb.ConnCase
  use Timex
  alias MindTheGappWeb.ArrivalTimeView

  def generate_seed_date(days_from_today) do
    Timex.now
    |> Timex.add(%Timex.Duration{seconds: 3600 * 24 * -days_from_today, microseconds: 0, megaseconds: 0 })
  end

  describe "Arrival Time View" do
    test "" do
      arrival_averages = [
        [generate_seed_date(0), 0.1],
        [generate_seed_date(1), 1.5],
        [generate_seed_date(2), 0],
        [generate_seed_date(3), 1.0],
        [generate_seed_date(4), -1.0],
        [generate_seed_date(5), -0.4],
        [generate_seed_date(6), 4],
      ]

      expected_payload = [
        %{day: "Today", meanArrivalDifferences: 0.1},
        %{day: "Yesterday", meanArrivalDifferences: 1.5},
        %{day: "2 Days Ago", meanArrivalDifferences: 0},
        %{day: "3 Days Ago", meanArrivalDifferences: 1.0},
        %{day: "4 Days Ago", meanArrivalDifferences: -1.0},
        %{day: "5 Days Ago", meanArrivalDifferences: -0.4},
        %{day: "6 Days Ago", meanArrivalDifferences: 4},
      ]

      assert expected_payload == Phoenix.View.render(ArrivalTimeView, "index.json", data: arrival_averages)
    end
  end
end
