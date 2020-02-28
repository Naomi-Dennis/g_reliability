defmodule MindTheGapp.Repo do
  use Ecto.Repo,
    otp_app: :mind_the_gapp,
    adapter: Ecto.Adapters.Postgres
end
