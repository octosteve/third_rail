defmodule ThirdRail.Repo do
  use Ecto.Repo,
    otp_app: :third_rail,
    adapter: Ecto.Adapters.Postgres
end
