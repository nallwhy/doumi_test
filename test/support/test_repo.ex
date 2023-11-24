defmodule Doumi.Test.TestRepo do
  use Ecto.Repo,
    otp_app: :doumi_test,
    adapter: Ecto.Adapters.SQLite3

  @impl true
  def init(_type, opts) do
    opts = Keyword.merge(opts, database: "./database/test.db", pool: Ecto.Adapters.SQL.Sandbox)

    {:ok, opts}
  end
end
