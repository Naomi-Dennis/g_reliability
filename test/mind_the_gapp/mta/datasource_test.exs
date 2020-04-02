defmodule MindTheGapp.Mta.DatasourceTest do
  use MindTheGapp.DataCase, async: true
  alias TransitRealtime.TripUpdate.StopTimeEvent
  alias MindTheGapp.Mta.Datasource
  alias MindTheGapp.Mta.DatasourceParser

  describe "Realtime Data Source MTA" do
    test "#source returns a list of arrival_time data" do
      fake_data = %StopTimeEvent{delay: 0, time: 15_342_134, uncertainty: 0}

      fake_decoder = fn encoded_object ->
        StopTimeEvent.decode(encoded_object)
      end

      ping_fake_api = fn url ->
        %{body: StopTimeEvent.encode(fake_data)}
      end

      assert fake_data = Datasource.source(ping_fake_api, "some_url", fake_decoder)
    end
  end
end
