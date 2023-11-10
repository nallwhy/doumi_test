defmodule Doumi.Test do
  @doc """
  Compare two values for equality.

  ## Examples
      iex> Doumi.Test.same_values?(1, 1)
      true

      iex> Doumi.Test.same_values?("foo", "bar")
      false

      iex> Doumi.Test.same_values?(~U[2023-01-01 00:00:00Z], ~U[2023-01-01 00:00:00.000Z])
      true

      iex> Doumi.Test.same_values?(Decimal.new("1.1"), 1.1)
      true
  """
  @spec same_values?(any(), any()) :: boolean()
  def same_values?(%DateTime{} = a, %DateTime{} = b), do: DateTime.compare(a, b) == :eq

  if Code.ensure_loaded?(Decimal) do
    def same_values?(%Decimal{} = a, %Decimal{} = b), do: Decimal.equal?(a, b)
    def same_values?(%Decimal{} = a, b) when is_integer(b), do: Decimal.equal?(a, b)

    def same_values?(%Decimal{} = a, b) when is_float(b),
      do: Decimal.equal?(a, Decimal.from_float(b))

    def same_values?(%Decimal{} = a, b) when is_binary(b), do: Decimal.equal?(a, Decimal.new(b))
    def same_values?(a, %Decimal{} = b), do: same_values?(b, a)
  end

  def same_values?(a, b), do: a == b
end
