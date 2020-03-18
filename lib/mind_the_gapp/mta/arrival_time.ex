defmodule MindTheGapp.Mta.ArrivalTime do
  alias MindTheGapp.Repo

  def difference_in_arrival_times() do
    {:ok, queryResults} = query_estimated_vs_arrival_difference()
    queryResults.rows
  end

  defp query_estimated_vs_arrival_difference() do
    query = "
    SELECT
        DATE_TRUNC('day', actual AT TIME ZONE 'UTC') AS day,
       ROUND(
        AVG(
           EXTRACT(MINUTE FROM actual::timestamp - estimated::timestamp)
          )::NUMERIC, 2)::FLOAT AS difference
    FROM arrival_times
    GROUP BY day
    ORDER BY day DESC
    LIMIT 8
    "
    Ecto.Adapters.SQL.query(Repo, query)
  end
end
