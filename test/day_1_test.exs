defmodule AdventTest.Day1Test do
  use ExUnit.Case

  describe "Day 1" do
    test "part 1" do
      assert Advent.Day1.part_1(["+1", "-2", "+3", "+1"]) == 3
      assert Advent.Day1.part_1(["+1", "+1", "+1"]) == 3
      assert Advent.Day1.part_1(["+1", "+1", "-2"]) == 0
      assert Advent.Day1.part_1(["-1", "-2", "-3"]) == -6
    end

    test "part 2" do
      assert Advent.Day1.part_2(["+1", "-2", "+3", "+1", "+1", "-2"]) == 2
      assert Advent.Day1.part_2(["+1", "-1"]) == 0
      assert Advent.Day1.part_2(["+3", "+3", "+4", "-2", "-4"]) == 10
      assert Advent.Day1.part_2(["-6", "+3", "+8", "+5", "-6"]) == 5
      assert Advent.Day1.part_2(["+7", "+7", "-2", "-7", "-4"]) == 14
    end
  end
end
