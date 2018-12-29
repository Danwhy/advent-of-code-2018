defmodule AdventTest.Day10Test do
  use ExUnit.Case

  describe "Day 10 - part 1" do
    test "parse input" do
      assert Advent.Day10.parse_input("position=< 9,  1> velocity=< 0,  2>") == [9, 1, 0, 2]
      assert Advent.Day10.parse_input("position=<-3, 11> velocity=< 1, -2>") == [-3, 11, 1, -2]
      assert Advent.Day10.parse_input("position=< 3,  6> velocity=<-1, -1>") == [3, 6, -1, -1]
    end
  end
end
