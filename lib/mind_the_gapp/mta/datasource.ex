defmodule MindTheGapp.Mta.Datasource do
  def source(ping_api, url, decoder) do
    response = ping_api.(url)
    decoder.(response.body)
  end
end
