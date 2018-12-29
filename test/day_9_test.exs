defmodule AdventTest.Day9Test do
  use ExUnit.Case
  doctest CircularList

  describe "Day 9 - part 1" do
    test "part 1" do
      assert Advent.Day9.part_1("2 players; last marble is worth 25 points") == 32
      assert Advent.Day9.part_1("10 players; last marble is worth 1618 points") == 8317
      assert Advent.Day9.part_1("13 players; last marble is worth 7999 points") == 146_373
      assert Advent.Day9.part_1("17 players; last marble is worth 1104 points") == 2764
      assert Advent.Day9.part_1("21 players; last marble is worth 6111 points") == 54718
      assert Advent.Day9.part_1("30 players; last marble is worth 5807 points") == 37305
    end
  end
end
