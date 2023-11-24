defmodule Doumi.Test.EctoTest do
  use Doumi.Test.DataCase
  import Doumi.Test.Ecto

  defmodule TestModule do
    use Ecto.Schema

    schema "tests" do
      field :field0, :integer
    end
  end

  describe "reload/2" do
    setup do
      record =
        TestRepo.insert!(%TestModule{
          field0: 0
        })

      %{record: record}
    end

    test "returns updated record with application env", %{record: record} do
      Application.put_env(:doumi_test, :default_repo, TestRepo)

      on_exit(fn ->
        Application.delete_env(:doumi_test, :default_repo)
      end)

      TestRepo.update!(Ecto.Changeset.change(record, %{field0: 1}))

      assert reloaded_record = reload(record)
      assert reloaded_record.field0 == 1
    end

    test "returns updated record with repo opts", %{record: record} do
      TestRepo.update!(Ecto.Changeset.change(record, %{field0: 1}))

      assert reloaded_record = reload(record, repo: TestRepo)
      assert reloaded_record.field0 == 1
    end

    test "returns nil with deleted record", %{record: record} do
      TestRepo.delete!(record)

      assert reload(record, repo: TestRepo) == nil
    end

    test "raise with no repo env, opts", %{record: record} do
      assert_raise ArgumentError, ~r/No repo found in opts or application env/, fn ->
        reload(record)
      end
    end
  end

  describe "reload!/2" do
    setup do
      record =
        TestRepo.insert!(%TestModule{
          field0: 0
        })

      %{record: record}
    end

    test "raise with no record exist (deleted)", %{record: record} do
      TestRepo.delete!(record)

      assert_raise ArgumentError, ~r/Could not find .+ in the database/, fn ->
        reload!(record, repo: TestRepo)
      end
    end
  end
end
