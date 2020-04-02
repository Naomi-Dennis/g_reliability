defmodule MindTheGapp.MtaTest do
  use MindTheGapp.DataCase, async: true
  alias MindTheGapp.ArrivalTime
  alias MindTheGapp.Repo
  alias MindTheGapp.Mta

  describe "Mta" do
    test "#accept_data inserts arrival time data in arrival_times table" do
      expected_arrival_data = fn ->
        [
          %{actual: ~U[2020-04-01 04:00:00.000000Z]}
        ]
      end

      Mta.accept_data(expected_arrival_data)

      assert Repo.exists?(
               from a in ArrivalTime, where: a.actual == ^~U[2020-04-01 04:00:00.000000Z]
             )
    end
  end
end
