if Code.ensure_loaded?(Ecto) do
  defmodule Doumi.Test.Ecto do
    def reload(record, opts \\ []) do
      {repo, opts} = opts |> Keyword.pop(:repo, Application.get_env(:doumi_test, :default_repo))

      if repo == nil do
        raise ArgumentError, "No repo found in opts or application env"
      end

      clauses =
        record.__struct__.__schema__(:primary_key)
        |> Enum.map(fn primary_key ->
          {primary_key, Map.get(record, primary_key)}
        end)

      repo.get_by(record.__struct__, clauses, opts)
    end

    def reload!(record, opts \\ []) do
      case reload(record, opts) do
        nil -> raise ArgumentError, "Could not find #{inspect(record)} in the database"
        value -> value
      end
    end
  end
end
