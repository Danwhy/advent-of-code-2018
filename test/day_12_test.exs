defmodule AdventTest.Day12Test do
  use ExUnit.Case

  @input [
    "initial state: #..#.#..##......###...###",
    "",
    "...## => #",
    "..#.. => #",
    ".#... => #",
    ".#.#. => #",
    ".#.## => #",
    ".##.. => #",
    ".#### => #",
    "#.#.# => #",
    "#.### => #",
    "##.#. => #",
    "##.## => #",
    "###.. => #",
    "###.# => #",
    "####. => #"
  ]

  describe "Day 12 - part 1" do
    test "parse input" do
      assert Advent.Day12.parse_input(@input) ==
               {%{
                  0 => "#",
                  1 => ".",
                  2 => ".",
                  3 => "#",
                  4 => ".",
                  5 => "#",
                  6 => ".",
                  7 => ".",
                  8 => "#",
                  9 => "#",
                  10 => ".",
                  11 => ".",
                  12 => ".",
                  13 => ".",
                  14 => ".",
                  15 => ".",
                  16 => "#",
                  17 => "#",
                  18 => "#",
                  19 => ".",
                  20 => ".",
                  21 => ".",
                  22 => "#",
                  23 => "#",
                  24 => "#"
                },
                %{
                  "...##" => "#",
                  "..#.." => "#",
                  ".#..." => "#",
                  ".#.#." => "#",
                  ".#.##" => "#",
                  ".##.." => "#",
                  ".####" => "#",
                  "#.#.#" => "#",
                  "#.###" => "#",
                  "##.#." => "#",
                  "##.##" => "#",
                  "###.." => "#",
                  "###.#" => "#",
                  "####." => "#"
                }}
    end

    test "generation" do
      assert Advent.Day12.parse_input(@input)
             |> Advent.Day12.generation(1)
             |> Enum.sort_by(fn {k, _} -> k end)
             |> Enum.map(fn {_, v} -> v end)
             |> Enum.join() == "...#...#....#.....#..#..#..#..."

      assert Advent.Day12.parse_input(@input)
             |> Advent.Day12.generation(2)
             |> Enum.sort_by(fn {k, _} -> k end)
             |> Enum.map(fn {_, v} -> v end)
             |> Enum.join() == "...##..##...##....#..#..#..##.."

      assert Advent.Day12.parse_input(@input)
             |> Advent.Day12.generation(20)
             |> Enum.sort_by(fn {k, _} -> k end)
             |> Enum.map(fn {_, v} -> v end)
             |> Enum.join() == ".#....##....#####...#######....#.#..##.."
    end

    test "part 1" do
      assert Advent.Day12.part_1(@input, 20) == 325
    end
  end
end
