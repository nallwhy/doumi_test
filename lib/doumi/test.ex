defmodule Doumi.Test do
  defmacro __using__(_opts) do
    quote do
      import Doumi.Test.Assertions
      import Doumi.Test.Ecto
    end
  end
end
