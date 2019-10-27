defmodule IdenticonGeneratorTest do
  use ExUnit.Case
  doctest IdenticonGenerator.Identicon

  test "greets the world" do
    assert IdenticonGenerator.Identicon.mirror_row([200, 201, 202]) == [200, 201, 202, 201, 200]
  end
end
