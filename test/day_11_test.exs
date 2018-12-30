defmodule AdventTest.Day11Test do
  use ExUnit.Case

  describe "Day 11 - part 1" do
    test "build grid" do
      row = fn row_num ->
        Advent.Day11.build_grid(18)
        |> elem(row_num)
      end

      assert elem(row.(45), 33) == 4
      assert elem(row.(45), 34) == 4
      assert elem(row.(45), 35) == 4
      assert elem(row.(46), 33) == 3
      assert elem(row.(46), 34) == 3
      assert elem(row.(46), 35) == 4
      assert elem(row.(47), 33) == 1
      assert elem(row.(47), 34) == 2
      assert elem(row.(47), 35) == 4
    end

    test "calculate total power" do
      assert Advent.Day11.calculate_total_power(Advent.Day11.build_grid(18), 33, 45, 3) == 29
    end

    test "part 1" do
      assert Advent.Day11.part_1(18) == {33, 45}
    end
  end
end
