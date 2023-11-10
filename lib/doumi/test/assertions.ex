defmodule Doumi.Test.Assertions do
  @doc """
  Assert that two values are the same.

  ## Examples
      iex> assert_same_values 1, 1
      true

      iex> assert_same_values 1, 2
      ** (ExUnit.AssertionError)

      `1` and `2` are not the same values
  """
  defmacro assert_same_values(a, b) do
    quote bind_quoted: [a: a, b: b] do
      if Doumi.Test.same_values?(a, b) do
        assert true
      else
        raise ExUnit.AssertionError,
          message: "`#{inspect(a)}` and `#{inspect(b)}` are not the same values"
      end
    end
  end

  @doc """
  Assert that two maps have the same value for a given fields.
  The two maps must always contain the given field.

  ## Examples
      iex> assert_same_fields %{a: 1, b: 2}, %{a: 1, b: 2}, [:a, :b]
      true

      iex> assert_same_fields %{a: 1, b: 2}, %{a: 1, b: 3}, [:a, :b]
      ** (ExUnit.AssertionError)

      The two maps have different values for the given fields
  """
  defmacro assert_same_fields(a, b, keys) do
    quote bind_quoted: [a: a, b: b, keys: keys] do
      if Doumi.Test.same_fields?(a, b, keys) do
        assert true
      else
        raise ExUnit.AssertionError,
          message: "The two maps have different values for the given fields",
          left: a,
          right: b
      end
    end
  end
end
