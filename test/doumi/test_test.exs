defmodule Doumi.TestTest do
  use ExUnit.Case, async: true
  alias Doumi.Test
  doctest Doumi.Test

  describe "same_values?/2" do
    test "returns true comparing two DateTimes with the same value but different precision" do
      assert Test.same_values?(~U[2023-01-01 00:00:00Z], ~U[2023-01-01 00:00:00.000Z]) == true
    end

    test "returns false comparing two DateTimes with different values" do
      assert Test.same_values?(~U[2023-01-01 00:00:00Z], ~U[2023-01-01 00:00:01Z]) == false
    end

    test "returns true comparing two Decimals with the same value" do
      assert Test.same_values?(Decimal.new("1.1"), Decimal.new("1.1")) == true
    end

    test "returns true comparing Decimal and integer with the same value" do
      assert Test.same_values?(Decimal.new("1"), 1) == true
      assert Test.same_values?(1, Decimal.new("1")) == true
    end

    test "returns false comparing Decimal and integer with different values" do
      assert Test.same_values?(Decimal.new("1"), 2) == false
      assert Test.same_values?(2, Decimal.new("1")) == false
    end

    test "returns true comparing Decimal and float with the same value" do
      assert Test.same_values?(Decimal.new("1.1"), 1.1) == true
      assert Test.same_values?(1.1, Decimal.new("1.1")) == true
    end

    test "returns false comparing Decimal and float with different values" do
      assert Test.same_values?(Decimal.new("1.1"), 1.2) == false
      assert Test.same_values?(1.2, Decimal.new("1.1")) == false
    end

    test "returns true comparing Decimal and string with the same value" do
      assert Test.same_values?(Decimal.new("1.1"), "1.1") == true
      assert Test.same_values?("1.1", Decimal.new("1.1")) == true
    end

    test "returns false comparing Decimal and string with different values" do
      assert Test.same_values?(Decimal.new("1.1"), "1.2") == false
      assert Test.same_values?("1.2", Decimal.new("1.1")) == false
    end

    test "returns true comparing the same things" do
      assert Test.same_values?(1, 1) == true
      assert Test.same_values?(1.1, 1.1) == true
      assert Test.same_values?("foo", "foo") == true
    end

    test "returns false comparing two different things" do
      assert Test.same_values?(1, 2) == false
      assert Test.same_values?(1.1, 1.2) == false
      assert Test.same_values?("foo", "bar") == false
    end
  end

  describe "same_fields?/2" do
    test "returns true comparing two maps with the same values for the given fields" do
      assert Test.same_fields?(
               %{a: ~U[2023-01-01 00:00:00Z], b: Decimal.new("1.1")},
               %{a: ~U[2023-01-01 00:00:00.000Z], b: 1.1},
               [:a, :b]
             ) == true
    end

    test "returns false comparing two maps with different values for the given fields" do
      assert Test.same_fields?(
               %{a: ~U[2023-01-01 00:00:00Z], b: Decimal.new("1.1")},
               %{a: ~U[2023-01-01 00:00:01Z], b: Decimal.new("1.1")},
               [:a, :b]
             ) == false
    end

    test "throws error when one of maps doesn't contain the given field" do
      assert_raise KeyError, ~r/key :b not found in/, fn ->
        Test.same_fields?(%{a: 1}, %{a: 1, b: 2}, [:a, :b])
      end
    end
  end
end
