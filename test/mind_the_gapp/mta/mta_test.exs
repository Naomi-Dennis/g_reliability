defmodule MtaTest do
  use MindTheGapp.DataCase, async: true
  alias Ecto.Query

  alias MindTheGapp.Mta
  alias MindTheGapp.Repo
  alias MindTheGapp.ArrivalTime

  describe "Mta" do
    test "#ingest" do
      api_consumer = fn ->
        [
          %{arrival: ~N[2015-01-01 00:00:00], stop_id: "1", trip_id: "A",}
        ]
      end

      Mta.ingest(api_consumer)
      assert Repo.exists?(from a in ArrivalTime, where: a.actual == ^~N[2015-01-01 00:00:00])
    end
  end
end
