# Doumi.Test

[![Hex Version](https://img.shields.io/hexpm/v/doumi_test.svg)](https://hex.pm/packages/doumi_test)
[![Hex Docs](https://img.shields.io/badge/hex-docs-lightgreen.svg)](https://hexdocs.pm/doumi_test/)
[![License](https://img.shields.io/hexpm/l/doumi_test.svg)](https://github.com/nallwhy/doumi_test/blob/master/LICENSE.md)
[![Last Updated](https://img.shields.io/github/last-commit/nallwhy/doumi_test.svg)](https://github.com/nallwhy/doumi_test/commits/main)

<!-- MDOC !-->

`Doumi.Test` is a helper library that make it easier to test your Elixir codes.

**도우미(Doumi)** means "helper" in Korean.

## Usage

### `assert_same_values/2`

```elixir
defmodule MyApp.Test do
  use ExUnit.Case
  use Doumi.Test

  test "returns true with the same values" do
    number1 = 1
    number2 = 1.0

    datetime1 = ~U[2023-11-11 00:00:00Z]
    datetime2 = ~U[2023-11-11 00:00:00.000Z]

    decimal1 = Decimal.new("1.1")
    decimal2 = 1.1

    # instead of
    assert number1 == number2
    assert DateTime.compare(datetime1, datetime2) == :eq
    assert Decimal.equal?(decimal1, decimal2)

    # do
    assert_same_values number1, number2
    assert_same_values datetime1, datetime2
    assert_same_values decimal1, decimal2
  end
end
```

### `assert_same_fields/3`

```elixir
defmodule MyApp.Test do
  use ExUnit.Case
  use Doumi.Test

  test "returns true with the same fields" do
    attrs = %{
      name: "name",
      age: 30,
      married: false
    }

    assert {:ok, something} = create_something(attrs)

    # instead of
    assert something.name == attrs.name
    assert something.age == attrs.age
    assert something.married == attrs.married

    # do
    assert_same_fields something, attrs, [:name, :age, :married]
  end
end
```

### `assert_same_records/2`

```elixir
defmodule MyApp.Test do
  use MyApp.DataCase
  use Doumi.Test

  test "returns true with the same records" do
    something = insert(:something)

    assert {:ok, fetched_something} = fetch_something(something.primary_key0, something.primary_key1)

    # instead of
    assert fetched_something.primary_key0 == something.primary_key0
    assert fetched_something.primary_key1 == something.primary_key1

    # do
    assert_same_records fetched_something, something
  end
end
```

### `reload/2`, `reload!/2`

```elixir
defmodule MyApp.Test do
  use MyApp.DataCase
  use Doumi.Test

  test "reload record" do
    counter = insert(:counter)

    assert :ok = increase_counter_and_no_return(counter)

    updated_counter = reload!(counter)

    assert updated_counter.count == counter.count + 1
  end
end
```

## Installation

The package can be installed by adding `doumi_test` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [
    {:doumi_test, "~> 0.1.0"}
  ]
end
```

To configure formatter, add `:doumi_test` to `import_deps` of `.formatter.exs`:

```elixir
[
  ...
  import_deps: [..., :doumi_test]
]
```

<!-- MDOC !-->

## Doumi\*

All **Doumi** libraries:

- [Doumi.Port](https://github.com/nallwhy/doumi_port): A helper library that makes it easier to use Python, Ruby in Elixir
- [Doumi.Phoenix.SVG](https://github.com/nallwhy/doumi_phoenix_svg): A helper library that generates Phoenix function components from SVG files.
- [Doumi.Phoenix.Params](https://github.com/nallwhy/doumi_phoenix_params): A helper library that supports converting form to params and params to form
- [Doumi.URI.Query](https://github.com/nallwhy/doumi_uri_query): A helper library that encode complicated query of URI.

## Copyright and License

Copyright (c) 2023 Jinkyou Son (Json)

This work is free. You can redistribute it and/or modify it under the
terms of the MIT License. See the [LICENSE.md](./LICENSE.md) file for more details.
