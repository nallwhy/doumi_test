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
end
