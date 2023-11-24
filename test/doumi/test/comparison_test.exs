defmodule Doumi.Test.ComparisonTest do
  use ExUnit.Case, async: true
  alias Doumi.Test.Comparison
  doctest Doumi.Test.Comparison

  describe "same_values?/2" do
    test "returns true comparing two DateTimes with the same value but different precision" do
      assert Comparison.same_values?(~U[2023-01-01 00:00:00Z], ~U[2023-01-01 00:00:00.000Z]) ==
               true
    end

    test "returns false comparing two DateTimes with different values" do
      assert Comparison.same_values?(~U[2023-01-01 00:00:00Z], ~U[2023-01-01 00:00:01Z]) == false
    end

    test "returns true comparing two Decimals with the same value" do
      assert Comparison.same_values?(Decimal.new("1.1"), Decimal.new("1.1")) == true
    end

    test "returns true comparing Decimal and integer with the same value" do
      assert Comparison.same_values?(Decimal.new("1"), 1) == true
      assert Comparison.same_values?(1, Decimal.new("1")) == true
    end

    test "returns false comparing Decimal and integer with different values" do
      assert Comparison.same_values?(Decimal.new("1"), 2) == false
      assert Comparison.same_values?(2, Decimal.new("1")) == false
    end

    test "returns true comparing Decimal and float with the same value" do
      assert Comparison.same_values?(Decimal.new("1.1"), 1.1) == true
      assert Comparison.same_values?(1.1, Decimal.new("1.1")) == true
    end

    test "returns false comparing Decimal and float with different values" do
      assert Comparison.same_values?(Decimal.new("1.1"), 1.2) == false
      assert Comparison.same_values?(1.2, Decimal.new("1.1")) == false
    end

    test "returns true comparing Decimal and string with the same value" do
      assert Comparison.same_values?(Decimal.new("1.1"), "1.1") == true
      assert Comparison.same_values?("1.1", Decimal.new("1.1")) == true
    end

    test "returns false comparing Decimal and string with different values" do
      assert Comparison.same_values?(Decimal.new("1.1"), "1.2") == false
      assert Comparison.same_values?("1.2", Decimal.new("1.1")) == false
    end

    test "returns true comparing the same things" do
      assert Comparison.same_values?(1, 1) == true
      assert Comparison.same_values?(1.1, 1.1) == true
      assert Comparison.same_values?("foo", "foo") == true
    end

    test "returns false comparing two different things" do
      assert Comparison.same_values?(1, 2) == false
      assert Comparison.same_values?(1.1, 1.2) == false
      assert Comparison.same_values?("foo", "bar") == false
    end
  end

  describe "same_fields?/2" do
    test "returns true comparing two maps with the same values for the given fields" do
      assert Comparison.same_fields?(
               %{a: ~U[2023-01-01 00:00:00Z], b: Decimal.new("1.1")},
               %{a: ~U[2023-01-01 00:00:00.000Z], b: 1.1},
               [:a, :b]
             ) == true
    end

    test "returns false comparing two maps with different values for the given fields" do
      assert Comparison.same_fields?(
               %{a: ~U[2023-01-01 00:00:00Z], b: Decimal.new("1.1")},
               %{a: ~U[2023-01-01 00:00:01Z], b: Decimal.new("1.1")},
               [:a, :b]
             ) == false
    end

    test "throws error when one of maps doesn't contain the given field" do
      assert_raise KeyError, ~r/key :b not found in/, fn ->
        Comparison.same_fields?(%{a: 1}, %{a: 1, b: 2}, [:a, :b])
      end
    end
  end

  describe "same_records?/2" do
    defmodule TestModule1 do
      use Ecto.Schema

      @primary_key false
      schema "test1" do
        field(:primary_key0, :integer, primary_key: true)
        field(:primary_key1, :string, primary_key: true)
        field(:field0, :integer)
      end
    end

    defmodule TestModule2 do
      use Ecto.Schema

      @primary_key false
      schema "test2" do
        field(:primary_key0, :integer, primary_key: true)
        field(:field0, :integer)
      end
    end

    test "returns true with the two records have the same primary keys" do
      primary_key0 = 1
      primary_key1 = "a"

      record0 = %TestModule1{
        primary_key0: primary_key0,
        primary_key1: primary_key1,
        field0: 1
      }

      record1 = %TestModule1{
        primary_key0: primary_key0,
        primary_key1: primary_key1,
        field0: 2
      }

      assert Comparison.same_records?(record0, record1) == true
    end

    test "returns false with the two records have different primary keys" do
      primary_key0 = 1

      record0 = %TestModule1{
        primary_key0: primary_key0,
        primary_key1: "a",
        field0: 1
      }

      record1 = %TestModule1{
        primary_key0: primary_key0,
        primary_key1: "b",
        field0: 1
      }

      assert Comparison.same_records?(record0, record1) == false
    end

    test "returns false with different schemas" do
      primary_key0 = 1
      primary_key1 = "a"

      record0 = %TestModule1{
        primary_key0: primary_key0,
        primary_key1: primary_key1,
        field0: 1
      }

      record1 = %TestModule2{
        primary_key0: primary_key0,
        field0: 1
      }

      assert Comparison.same_records?(record0, record1) == false
    end

    test "throws error when one of input is not a record" do
      assert_raise KeyError, ~r/key :__struct__ not found in:/, fn ->
        Comparison.same_records?(%{}, %TestModule1{})
      end
    end
  end
end
