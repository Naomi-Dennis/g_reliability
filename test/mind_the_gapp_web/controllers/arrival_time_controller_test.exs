defmodule MindTheGappWeb.ArrivalTimeControllerTest do
  use MindTheGappWeb.ConnCase, async: true
  use Timex
  alias MindTheGapp.ArrivalTime

  setup :create_fake_arrival_time_data


  def create_fake_arrival_time_data(_context) do
    generate_fake_arrival_data()
    :ok
  end

  def generate_fake_arrival_data() do
    starting_date = DateTime.utc_now

     1..50
     |> Enum.reduce(starting_date, &persist_arrival_time/2)
  end

  def persist_arrival_time(_x, date_time) do
    actual_time = DateTime.add(date_time, Enum.random(-10..10) * 60)

     %MindTheGapp.ArrivalTime{estimated: date_time, actual: actual_time}
     |> MindTheGapp.Repo.insert!()

    date_time |> DateTime.add(3600 * -6)
  end
  describe "Arrival Time Controller" do
    test "GET / returns a JSON object", %{conn: conn} do
      conn = get(conn, "/")
      assert json_response(conn, 200)
    end

    test "GET / returns a list of JSON objects whose attributes are 'day' and 'meanArrivalDifferences'", %{conn: conn} do
      expected_attributes = ["day","meanArrivalDifferences"]
      conn = get(conn, "/")
      {:ok, retrieved_objects} = conn.resp_body
                                 |> Jason.decode
      retrieved_keys = retrieved_objects
                       |> List.first
                       |> Map.keys
      assert retrieved_keys == expected_attributes
    end

    test "GET / returns a list of JSON objects, the 'meanArrivalDifferences' attributes are floats", %{conn: conn} do
      conn = get(conn, "/")
      {:ok, retrieved_objects} = conn.resp_body
                                |> Jason.decode
      all_mean_differences_are_floats = retrieved_objects
                                   |> Enum.all?(fn arrival_time -> arrival_time["meanArrivalDifferences"] |> is_float end)
      assert all_mean_differences_are_floats
    end

    test "GET / returns a list of JSON objects, the 'day' attributes are labels for days with arrival times" , %{conn: conn} do
      conn = get(conn, "/")
      expected_labels = ["Today", "Yesterday", "2 Days Ago", "3 Days Ago", "4 Days Ago", "5 Days Ago", "6 Days Ago", "7 Days Ago"]
      {:ok, retrieved_objects} = conn.resp_body
                                 |> Jason.decode
      each_day_is_an_expected_label = retrieved_objects
                                      |> Enum.all?(fn arrival_time -> Enum.member?(expected_labels, arrival_time["day"]) end)
      assert each_day_is_an_expected_label
    end
  end
end
