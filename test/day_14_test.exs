defmodule AdventTest.Day14Test do
  use ExUnit.Case

  describe "Day 14 - part 1" do
    test "part 1" do
      assert Advent.Day14.part_1(9) == "5158916779"
      assert Advent.Day14.part_1(5) == "0124515891"
      assert Advent.Day14.part_1(18) == "9251071085"
      assert Advent.Day14.part_1(2018) == "5941429882"
    end
  end
end
