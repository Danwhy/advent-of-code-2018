defmodule AdventTest.Day4Test do
  use ExUnit.Case

  describe "Day 5 - part 1" do
    test "part 1" do
      assert Advent.Day5.part_1("dabAcCaCBAcCcaDA" |> String.split("", trim: true)) == 10
      assert Advent.Day5.part_1("FuUmMfRbBVvYyzZrzZuUohNnH" |> String.split("", trim: true)) == 10
    end

    test "compare adjacent" do
      assert Advent.Day5.compare_adjacent(
               "FuUmMfRbBVvYyzZrzZuUohNnH"
               |> String.split("", trim: true)
             ) == "o"
    end
  end
end
