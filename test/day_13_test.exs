defmodule AdventTest.Day13Test do
  use ExUnit.Case

  @input ~s"""
  /->-\\\s\s\s\s\s\s\s\s
  |   |  /----\\
  | /-+--+-\\  |
  | | |  | v  |
  \\-+-/  \\-+--/
  \s\s\\------/\s\s\s
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
end
