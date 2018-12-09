defmodule AdventTest.Day3Test do
  use ExUnit.Case

  describe "Day 3 - part 1" do
    test "get size of fabric" do
      assert Advent.Day3.get_size(["#123 @ 3,2: 5x4"]) == 8
      assert Advent.Day3.get_size(["#1 @ 1,3: 4x4", "#2 @ 3,1: 4x4", "#3 @ 5,5: 2x2"]) == 7
    end

    test "represent fabric" do
      assert Advent.Day3.create_fabric(2) == [[nil, nil], [nil, nil]]
      assert Advent.Day3.create_fabric(3) == [[nil, nil, nil], [nil, nil, nil], [nil, nil, nil]]

      assert Advent.Day3.create_fabric(4) == [
               [nil, nil, nil, nil],
               [nil, nil, nil, nil],
               [nil, nil, nil, nil],
               [nil, nil, nil, nil]
             ]

      fabric = Advent.Day3.create_fabric(99)
      assert length(fabric) == 99
      assert length(List.first(fabric)) == 99
    end

    test "part 1" do
      assert Advent.Day3.part_1(["#1 @ 1,3: 4x4", "#2 @ 3,1: 4x4", "#3 @ 5,5: 2x2"]) == 4
      assert Advent.Day3.part_1(["#123 @ 3,2: 5x4"]) == 0
      assert Advent.Day3.part_1(["#123 @ 3,2: 5x4", "#456 @  1,1: 3x2"]) == 1
    end
  end
end
