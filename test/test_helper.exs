defmodule Doumi.Test.Migrations.CreateForTests do
  use Ecto.Migration

  def change do
    create table(:tests) do
      add(:field0, :integer, null: false)
    end
  end
end

Doumi.Test.TestRepo.start_link()

# Mix.Task.run("ecto.drop", ["quiet", "-r", "Doumi.Test.TestRepo"])
Mix.Task.run("ecto.create", ["quiet", "-r", "Doumi.Test.TestRepo"])

Ecto.Migrator.run(
  Doumi.Test.TestRepo,
  [{0, Doumi.Test.Migrations.CreateForTests}],
  :up,
  all: true
)

ExUnit.start()
