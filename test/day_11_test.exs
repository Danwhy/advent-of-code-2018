defmodule AdventTest.Day11Test do
  use ExUnit.Case

  describe "Day 11 - part 1" do
    test "build grid" do
      row = fn row_num ->
        Advent.Day11.build_grid(18)
        |> Enum.map(fn {c, _} -> c end)
        |> Enum.at(row_num)
        |> Enum.map(fn {c, _} -> c end)
      end

      assert Enum.slice(row.(45), 33..35) == [4, 4, 4]
      assert Enum.slice(row.(46), 33..35) == [3, 3, 4]
      assert Enum.slice(row.(47), 33..35) == [1, 2, 4]
    end

    test "calculate total power" do
      assert Advent.Day11.calculate_total_power(Advent.Day11.build_grid(18), 33, 45) == 29
    end

    test "part 1" do
      assert Advent.Day11.part_1(18) == {33, 45}
    end
  end
end
