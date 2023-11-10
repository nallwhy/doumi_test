defmodule Doumi.Test.AssertionsTest do
  use ExUnit.Case, async: true
  import Doumi.Test.Assertions

  describe "assert_same_values/2" do
    test "with the same values" do
      assert_same_values 1, 1
    end

    test "with not the same values" do
      try do
        assert_same_values 1, 2
      rescue
        error in ExUnit.AssertionError ->
          assert error.message == "`1` and `2` are not the same values"
      end
    end
  end

  describe "assert_same_fields/3" do
    test "with the same fields" do
      assert_same_fields %{a: 1, b: 2}, %{a: 1, b: 2}, [:a, :b]
    end

    test "with not the same fields" do
      try do
        assert_same_fields %{a: 1, b: 2}, %{a: 1, b: 3}, [:a, :b]
      rescue
        error in ExUnit.AssertionError ->
          assert error.message == "The two maps have different values for the given fields"
          assert error.left == %{a: 1, b: 2}
          assert error.right == %{a: 1, b: 3}
      end
    end
  end
end
