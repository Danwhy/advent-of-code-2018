defmodule AdventTest.Day13Test do
  use ExUnit.Case

  @input ~s"""
  /->-\\\s\s\s\s\s\s\s\s
  |   |  /----\\
  | /-+--+-\\  |
  | | |  | v  |
  \\-+-/  \\-+--/
    \\------/\s\s\s
  """

  @input_2 ~s"""
  />-<\\\s\s
  |   |\s\s
  | /<+-\\
  | | | v
  \\>+</ |
    |   ^
    \\<->/
  """

  describe "Day 13 - part 1" do
    test "parse_input" do
      assert Advent.Day13.parse_input(@input) ==
               %{
                 track: [
                   ["/", "-", "-", "-", "\\", " ", " ", " ", " ", " ", " ", " ", " "],
                   ["|", " ", " ", " ", "|", " ", " ", "/", "-", "-", "-", "-", "\\"],
                   ["|", " ", "/", "-", "+", "-", "-", "+", "-", "\\", " ", " ", "|"],
                   ["|", " ", "|", " ", "|", " ", " ", "|", " ", "|", " ", " ", "|"],
                   ["\\", "-", "+", "-", "/", " ", " ", "\\", "-", "+", "-", "-", "/"],
                   [" ", " ", "\\", "-", "-", "-", "-", "-", "-", "/", " ", " ", " "]
                 ],
                 carts: [{2, 0, :east, :left}, {9, 3, :south, :left}]
               }
    end

    test "tick" do
      assert (Advent.Day13.parse_input(@input) |> Advent.Day13.tick()).carts == [
               {3, 0, :east, :left},
               {9, 4, :east, :straight}
             ]

      assert (Advent.Day13.parse_input(@input)
              |> Advent.Day13.tick()
              |> Advent.Day13.tick()).carts ==
               [
                 {4, 0, :south, :left},
                 {10, 4, :east, :straight}
               ]
    end

    test "part 1" do
      assert Advent.Day13.part_1(@input) == {7, 3}
    end
  end

  describe "Day 13 - part 2" do
    test "parse_input" do
      assert Advent.Day13.parse_input(@input_2)
             |> Map.get(:carts)
             |> Enum.sort_by(fn {_, y, _, _} -> y end) == [
               {1, 0, :east, :left},
               {3, 0, :west, :left},
               {3, 2, :west, :left},
               {6, 3, :south, :left},
               {1, 4, :east, :left},
               {3, 4, :west, :left},
               {6, 5, :north, :left},
               {3, 6, :west, :left},
               {5, 6, :east, :left}
             ]
    end

    test "tick" do
      assert Advent.Day13.parse_input(@input_2) |> Advent.Day13.tick(true) |> Map.get(:carts) ==
               [
                 {2, 2, :south, :left},
                 {2, 6, :north, :left},
                 {6, 6, :north, :left}
               ]
    end

    test "part 2" do
      assert Advent.Day13.part_2(@input_2) == {6, 4}
    end
  end
end
