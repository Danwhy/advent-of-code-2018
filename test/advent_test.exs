defmodule AdventTest do
  use ExUnit.Case
  doctest Advent

  test "Advent module runs each day" do
    assert Advent.run(:day_1)
    assert Advent.run(:day_1, 2)

    assert Advent.run(:day_2)
    assert Advent.run(:day_2, 2)

    assert Advent.run(:day_3) == 104_126
  end
end
