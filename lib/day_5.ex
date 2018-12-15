defmodule Advent.Day5 do
  def calculate(part, input) do
    input =
      File.read!(input)
      |> String.split("", trim: true)

    apply(__MODULE__, String.to_existing_atom("part_" <> to_string(part)), [input])
  end

  def part_1(input) do
    input
    |> compare_adjacent()
    |> String.length()
  end

  def compare_adjacent([head | []]), do: head

  def compare_adjacent(["" | tail]), do: compare_adjacent(tail)

  def compare_adjacent([head | tail]) do
    left = String.last(head)
    [right | new_tail] = tail

    cond do
      left != right && String.upcase(left) == String.upcase(right) ->
        compare_adjacent([String.slice(head, 0..-2) | new_tail])

      true ->
        compare_adjacent([head <> right | new_tail])
    end
  end
end
