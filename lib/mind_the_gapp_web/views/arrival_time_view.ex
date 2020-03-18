defmodule MindTheGappWeb.ArrivalTimeView do
  use MindTheGappWeb, :view
  use Timex

  def render("index.json", %{data: data}) do
    render_many(data, MindTheGappWeb.ArrivalTimeView, "one.json")
  end

  def render("one.json", %{arrival_time: [day, average | _rest]}) do
    days_ago = determine_difference_in_date_from_today(day)
    day_label = determine_label(days_ago)
    %{day: day_label, meanArrivalDifferences: average}
  end

  defp determine_label(days_ago) do
    case days_ago do
      0 ->
        "Today"
      1 ->
        "Yesterday"
      _ ->
        "#{days_ago} Days Ago"
    end
  end

  defp determine_difference_in_date_from_today(day2) do
    (DateTime.diff(Timex.now, day2) / (24 * 3600)) |> Kernel.trunc
  end
end
