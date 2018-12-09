defmodule AdventTest do
  use ExUnit.Case
  doctest Advent

  test "Solution Day 1" do
    assert Advent.run(:day_1) == 416
    assert Advent.run(:day_1, 2) == 56752
  end

  test "Solution Day 2" do
    assert Advent.run(:day_2) == 6723
    assert Advent.run(:day_2, 2) == "prtkqyluiusocwvaezjmhmfgx"
  end

  @tag timeout: 100_000
  test "Solution Day 3" do
    assert Advent.run(:day_3) == 104_126
    assert Advent.run(:day_3, 2) == "695"
  end
end
