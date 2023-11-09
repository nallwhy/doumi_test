defmodule Doumi.TestTest do
  use ExUnit.Case
  doctest Doumi.Test

  test "greets the world" do
    assert Doumi.Test.hello() == :world
  end
end
