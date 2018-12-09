defmodule AdventTest do
  use ExUnit.Case
  doctest Advent

  @solutions 1..2

  test "Advent module runs each day" do
    @solutions
    |> Enum.each(fn s ->
      day = String.to_existing_atom("day_" <> to_string(s))

      assert Advent.run(day)
      assert Advent.run(day, 2)
    end)
  end

  test "Solution Day 1" do
    assert Advent.run(:day_1) == 416
    assert Advent.run(:day_1, 2) == 56752
  end

  test "Solution Day 2" do
    assert Advent.run(:day_2) == 6723
    assert Advent.run(:day_2, 2) == "prtkqyluiusocwvaezjmhmfgx"
  end

  test "Solution Day 3" do
    assert Advent.run(:day_3) == 104_126
  end
end
