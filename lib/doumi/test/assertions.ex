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
end
