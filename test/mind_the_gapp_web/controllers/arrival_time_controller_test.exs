defmodule MindTheGappWeb.ArrivalTimeControllerTest do
  use MindTheGappWeb.ConnCase, async: true
  use Timex
  alias MindTheGapp.ArrivalTime

  setup do
    FakeArrivalTimes.create_fake_arrival_time_data()
    :ok
  end

  describe "Arrival Time Controller" do
    test "GET / returns a JSON object", %{conn: conn} do
      conn = get(conn, "/")
      assert json_response(conn, 200)
    end

    test "GET / returns a list of JSON objects whose attributes are 'day' and 'meanArrivalDifferences'",
         %{conn: conn} do
      expected_attributes = ["day", "meanArrivalDifferences"]
      conn = get(conn, "/")

      {:ok, retrieved_objects} =
        conn.resp_body
        |> Jason.decode()

      retrieved_keys =
        retrieved_objects
        |> List.first()
        |> Map.keys()

      assert retrieved_keys == expected_attributes
    end

    test "GET / returns a list of JSON objects, the 'meanArrivalDifferences' attributes are floats",
         %{conn: conn} do
      conn = get(conn, "/")

      {:ok, retrieved_objects} =
        conn.resp_body
        |> Jason.decode()

      all_mean_differences_are_floats =
        retrieved_objects
        |> Enum.all?(fn arrival_time -> arrival_time["meanArrivalDifferences"] |> is_float end)

      assert all_mean_differences_are_floats
    end

    test "GET / returns a list of JSON objects, the 'day' attributes are labels for days with arrival times",
         %{conn: conn} do
      conn = get(conn, "/")

      expected_labels = [
        "Today",
        "Yesterday",
        "2 Days Ago",
        "3 Days Ago",
        "4 Days Ago",
        "5 Days Ago",
        "6 Days Ago",
        "7 Days Ago"
      ]

      {:ok, retrieved_objects} =
        conn.resp_body
        |> Jason.decode()

      each_day_is_an_expected_label =
        retrieved_objects
        |> Enum.all?(fn arrival_time -> Enum.member?(expected_labels, arrival_time["day"]) end)

      assert each_day_is_an_expected_label
    end
  end
end
