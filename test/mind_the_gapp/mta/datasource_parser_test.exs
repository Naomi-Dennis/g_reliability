defmodule MindTheGapp.Mta.DatasourceParserTest do
  use MindTheGapp.DataCase, async: true

  alias MindTheGapp.Mta.DatasourceParser
  alias TransitRealtime

  describe "Mta.DatasourceParser#parse" do
    test "it returns an empty when given no entites" do
      assert [] == DatasourceParser.parse([])
    end

    test "it will parse a GFTS response with a single entity with trip_update defined" do
      assert [
               %{trip_id: "062650_G..S", stop_id: "G24S", arrival: 1_585_837_650},
               %{trip_id: "062650_G..S", stop_id: "F26S", arrival: 1_585_839_600},
               %{trip_id: "062650_G..S", stop_id: "F27S", arrival: 1_585_839_690}
             ] == DatasourceParser.parse(single_entity_data())
    end

    test "it will parse a GFTS response with multiple entities with trip_udpate defined" do
      assert [
               %{trip_id: "062650_G..S", stop_id: "G24S", arrival: 1_585_837_650},
               %{trip_id: "062650_G..S", stop_id: "F26S", arrival: 1_585_839_600},
               %{trip_id: "062650_G..S", stop_id: "F27S", arrival: 1_585_839_690},
               %{trip_id: "062650_G..S", stop_id: "G24S", arrival: 1_585_837_650},
               %{trip_id: "062650_G..S", stop_id: "F26S", arrival: 1_585_839_600},
               %{trip_id: "062650_G..S", stop_id: "F27S", arrival: 1_585_839_690},
               %{trip_id: "062650_G..S", stop_id: "G24S", arrival: 1_585_837_650},
               %{trip_id: "062650_G..S", stop_id: "F26S", arrival: 1_585_839_600},
               %{trip_id: "062650_G..S", stop_id: "F27S", arrival: 1_585_839_690}
             ] == DatasourceParser.parse(multiple_entity_data())
    end

    test "it does not parse entites with a defined vehicle property" do
      assert [] == DatasourceParser.parse(vehicle_entity_data())
    end

    test "it correctly parses vehicle and trip_update entities" do
      assert [
               %{trip_id: "062650_G..S", stop_id: "G24S", arrival: 1_585_837_650},
               %{trip_id: "062650_G..S", stop_id: "F26S", arrival: 1_585_839_600}
             ] == DatasourceParser.parse(mixed_entity_data())
    end
  end

  defp mixed_entity_data do
    [
      %TransitRealtime.FeedEntity{
        alert: nil,
        id: "000016G",
        is_deleted: false,
        trip_update: nil,
        vehicle: %TransitRealtime.VehiclePosition{
          congestion_level: nil,
          current_status: :IN_TRANSIT_TO,
          current_stop_sequence: nil,
          occupancy_status: nil,
          position: nil,
          stop_id: "G22",
          timestamp: 1_585_848_090,
          trip: %TransitRealtime.TripDescriptor{
            direction_id: nil,
            route_id: "G",
            schedule_relationship: nil,
            start_date: "20200402",
            start_time: "13:21:30",
            trip_id: "080150_G..S"
          },
          vehicle: nil
        }
      },
      %TransitRealtime.FeedEntity{
        alert: nil,
        id: "000015G",
        is_deleted: false,
        trip_update: %TransitRealtime.TripUpdate{
          delay: nil,
          stop_time_update: [
            %TransitRealtime.TripUpdate.StopTimeUpdate{
              arrival: %TransitRealtime.TripUpdate.StopTimeEvent{
                delay: nil,
                time: 1_585_837_650,
                uncertainty: nil
              },
              departure: %TransitRealtime.TripUpdate.StopTimeEvent{
                delay: nil,
                time: 1_585_837_650,
                uncertainty: nil
              },
              schedule_relationship: :SCHEDULED,
              stop_id: "G24S",
              stop_sequence: nil
            },
            %TransitRealtime.TripUpdate.StopTimeUpdate{
              arrival: %TransitRealtime.TripUpdate.StopTimeEvent{
                delay: nil,
                time: 1_585_839_600,
                uncertainty: nil
              },
              departure: %TransitRealtime.TripUpdate.StopTimeEvent{
                delay: nil,
                time: 1_585_839_600,
                uncertainty: nil
              },
              schedule_relationship: :SCHEDULED,
              stop_id: "F26S",
              stop_sequence: nil
            }
          ],
          timestamp: nil,
          trip: %TransitRealtime.TripDescriptor{
            direction_id: nil,
            route_id: "G",
            schedule_relationship: nil,
            start_date: "20200402",
            start_time: "10:26:30",
            trip_id: "062650_G..S"
          },
          vehicle: nil
        },
        vehicle: nil
      }
    ]
  end

  defp vehicle_entity_data do
    [
      %TransitRealtime.FeedEntity{
        alert: nil,
        id: "000016G",
        is_deleted: false,
        trip_update: nil,
        vehicle: %TransitRealtime.VehiclePosition{
          congestion_level: nil,
          current_status: :IN_TRANSIT_TO,
          current_stop_sequence: nil,
          occupancy_status: nil,
          position: nil,
          stop_id: "G22",
          timestamp: 1_585_848_090,
          trip: %TransitRealtime.TripDescriptor{
            direction_id: nil,
            route_id: "G",
            schedule_relationship: nil,
            start_date: "20200402",
            start_time: "13:21:30",
            trip_id: "080150_G..S"
          },
          vehicle: nil
        }
      }
    ]
  end

  defp multiple_entity_data do
    [
      %TransitRealtime.FeedEntity{
        alert: nil,
        id: "000015G",
        is_deleted: false,
        trip_update: %TransitRealtime.TripUpdate{
          delay: nil,
          stop_time_update: [
            %TransitRealtime.TripUpdate.StopTimeUpdate{
              arrival: %TransitRealtime.TripUpdate.StopTimeEvent{
                delay: nil,
                time: 1_585_837_650,
                uncertainty: nil
              },
              departure: %TransitRealtime.TripUpdate.StopTimeEvent{
                delay: nil,
                time: 1_585_837_650,
                uncertainty: nil
              },
              schedule_relationship: :SCHEDULED,
              stop_id: "G24S",
              stop_sequence: nil
            },
            %TransitRealtime.TripUpdate.StopTimeUpdate{
              arrival: %TransitRealtime.TripUpdate.StopTimeEvent{
                delay: nil,
                time: 1_585_839_600,
                uncertainty: nil
              },
              departure: %TransitRealtime.TripUpdate.StopTimeEvent{
                delay: nil,
                time: 1_585_839_600,
                uncertainty: nil
              },
              schedule_relationship: :SCHEDULED,
              stop_id: "F26S",
              stop_sequence: nil
            },
            %TransitRealtime.TripUpdate.StopTimeUpdate{
              arrival: %TransitRealtime.TripUpdate.StopTimeEvent{
                delay: nil,
                time: 1_585_839_690,
                uncertainty: nil
              },
              departure: %TransitRealtime.TripUpdate.StopTimeEvent{
                delay: nil,
                time: 1_585_839_690,
                uncertainty: nil
              },
              schedule_relationship: :SCHEDULED,
              stop_id: "F27S",
              stop_sequence: nil
            }
          ],
          timestamp: nil,
          trip: %TransitRealtime.TripDescriptor{
            direction_id: nil,
            route_id: "G",
            schedule_relationship: nil,
            start_date: "20200402",
            start_time: "10:26:30",
            trip_id: "062650_G..S"
          },
          vehicle: nil
        },
        vehicle: nil
      },
      %TransitRealtime.FeedEntity{
        alert: nil,
        id: "000015G",
        is_deleted: false,
        trip_update: %TransitRealtime.TripUpdate{
          delay: nil,
          stop_time_update: [
            %TransitRealtime.TripUpdate.StopTimeUpdate{
              arrival: %TransitRealtime.TripUpdate.StopTimeEvent{
                delay: nil,
                time: 1_585_837_650,
                uncertainty: nil
              },
              departure: %TransitRealtime.TripUpdate.StopTimeEvent{
                delay: nil,
                time: 1_585_837_650,
                uncertainty: nil
              },
              schedule_relationship: :SCHEDULED,
              stop_id: "G24S",
              stop_sequence: nil
            },
            %TransitRealtime.TripUpdate.StopTimeUpdate{
              arrival: %TransitRealtime.TripUpdate.StopTimeEvent{
                delay: nil,
                time: 1_585_839_600,
                uncertainty: nil
              },
              departure: %TransitRealtime.TripUpdate.StopTimeEvent{
                delay: nil,
                time: 1_585_839_600,
                uncertainty: nil
              },
              schedule_relationship: :SCHEDULED,
              stop_id: "F26S",
              stop_sequence: nil
            },
            %TransitRealtime.TripUpdate.StopTimeUpdate{
              arrival: %TransitRealtime.TripUpdate.StopTimeEvent{
                delay: nil,
                time: 1_585_839_690,
                uncertainty: nil
              },
              departure: %TransitRealtime.TripUpdate.StopTimeEvent{
                delay: nil,
                time: 1_585_839_690,
                uncertainty: nil
              },
              schedule_relationship: :SCHEDULED,
              stop_id: "F27S",
              stop_sequence: nil
            }
          ],
          timestamp: nil,
          trip: %TransitRealtime.TripDescriptor{
            direction_id: nil,
            route_id: "G",
            schedule_relationship: nil,
            start_date: "20200402",
            start_time: "10:26:30",
            trip_id: "062650_G..S"
          },
          vehicle: nil
        },
        vehicle: nil
      },
      %TransitRealtime.FeedEntity{
        alert: nil,
        id: "000015G",
        is_deleted: false,
        trip_update: %TransitRealtime.TripUpdate{
          delay: nil,
          stop_time_update: [
            %TransitRealtime.TripUpdate.StopTimeUpdate{
              arrival: %TransitRealtime.TripUpdate.StopTimeEvent{
                delay: nil,
                time: 1_585_837_650,
                uncertainty: nil
              },
              departure: %TransitRealtime.TripUpdate.StopTimeEvent{
                delay: nil,
                time: 1_585_837_650,
                uncertainty: nil
              },
              schedule_relationship: :SCHEDULED,
              stop_id: "G24S",
              stop_sequence: nil
            },
            %TransitRealtime.TripUpdate.StopTimeUpdate{
              arrival: %TransitRealtime.TripUpdate.StopTimeEvent{
                delay: nil,
                time: 1_585_839_600,
                uncertainty: nil
              },
              departure: %TransitRealtime.TripUpdate.StopTimeEvent{
                delay: nil,
                time: 1_585_839_600,
                uncertainty: nil
              },
              schedule_relationship: :SCHEDULED,
              stop_id: "F26S",
              stop_sequence: nil
            },
            %TransitRealtime.TripUpdate.StopTimeUpdate{
              arrival: %TransitRealtime.TripUpdate.StopTimeEvent{
                delay: nil,
                time: 1_585_839_690,
                uncertainty: nil
              },
              departure: %TransitRealtime.TripUpdate.StopTimeEvent{
                delay: nil,
                time: 1_585_839_690,
                uncertainty: nil
              },
              schedule_relationship: :SCHEDULED,
              stop_id: "F27S",
              stop_sequence: nil
            }
          ],
          timestamp: nil,
          trip: %TransitRealtime.TripDescriptor{
            direction_id: nil,
            route_id: "G",
            schedule_relationship: nil,
            start_date: "20200402",
            start_time: "10:26:30",
            trip_id: "062650_G..S"
          },
          vehicle: nil
        },
        vehicle: nil
      }
    ]
  end

  defp single_entity_data do
    [
      %TransitRealtime.FeedEntity{
        alert: nil,
        id: "000015G",
        is_deleted: false,
        trip_update: %TransitRealtime.TripUpdate{
          delay: nil,
          stop_time_update: [
            %TransitRealtime.TripUpdate.StopTimeUpdate{
              arrival: %TransitRealtime.TripUpdate.StopTimeEvent{
                delay: nil,
                time: 1_585_837_650,
                uncertainty: nil
              },
              departure: %TransitRealtime.TripUpdate.StopTimeEvent{
                delay: nil,
                time: 1_585_837_650,
                uncertainty: nil
              },
              schedule_relationship: :SCHEDULED,
              stop_id: "G24S",
              stop_sequence: nil
            },
            %TransitRealtime.TripUpdate.StopTimeUpdate{
              arrival: %TransitRealtime.TripUpdate.StopTimeEvent{
                delay: nil,
                time: 1_585_839_600,
                uncertainty: nil
              },
              departure: %TransitRealtime.TripUpdate.StopTimeEvent{
                delay: nil,
                time: 1_585_839_600,
                uncertainty: nil
              },
              schedule_relationship: :SCHEDULED,
              stop_id: "F26S",
              stop_sequence: nil
            },
            %TransitRealtime.TripUpdate.StopTimeUpdate{
              arrival: %TransitRealtime.TripUpdate.StopTimeEvent{
                delay: nil,
                time: 1_585_839_690,
                uncertainty: nil
              },
              departure: %TransitRealtime.TripUpdate.StopTimeEvent{
                delay: nil,
                time: 1_585_839_690,
                uncertainty: nil
              },
              schedule_relationship: :SCHEDULED,
              stop_id: "F27S",
              stop_sequence: nil
            }
          ],
          timestamp: nil,
          trip: %TransitRealtime.TripDescriptor{
            direction_id: nil,
            route_id: "G",
            schedule_relationship: nil,
            start_date: "20200402",
            start_time: "10:26:30",
            trip_id: "062650_G..S"
          },
          vehicle: nil
        },
        vehicle: nil
      }
    ]
  end
end
