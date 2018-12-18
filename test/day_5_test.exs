defmodule AdventTest.Day5Test do
  use ExUnit.Case

  describe "Day 5 - part 1" do
    test "part 1" do
      assert Advent.Day5.part_1("dabAcCaCBAcCcaDA") == 10
      assert Advent.Day5.part_1("FuUmMfRbBVvYyzZrzZuUohNnH") == 1
    end

    test "compare adjacent" do
      assert Advent.Day5.compare_adjacent(
               "FuUmMfRbBVvYyzZrzZuUohNnH"
               |> String.split("", trim: true),
               []
             ) == ["o"]
    end
  end

  describe "Day 5 - part 2" do
    test "part 2" do
      assert Advent.Day5.part_2("dabAcCaCBAcCcaDA") == 4
    end
  end
end
