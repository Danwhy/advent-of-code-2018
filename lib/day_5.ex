defmodule Advent.Day5 do
  def calculate(part, input) do
    input = File.read!(input)

    apply(__MODULE__, String.to_existing_atom("part_" <> to_string(part)), [input])
  end

  def part_1(input) do
    input
    |> String.split("", trim: true)
    |> compare_adjacent([])
    |> length()
  end

  def part_2(input) do
    ?a..?z
    |> Enum.map(fn c ->
      input |> remove_polymer(c) |> String.split("", trim: true) |> compare_adjacent([])
    end)
    |> Enum.min_by(&length/1)
    |> length()
  end

  def compare_adjacent([], new), do: new

  def compare_adjacent([head | tail], []), do: compare_adjacent(tail, [head])

  def compare_adjacent([head | tail], [new_head | new_tail] = new) do
    cond do
      head != new_head && String.upcase(head) == String.upcase(new_head) ->
        compare_adjacent(tail, new_tail)

      true ->
        compare_adjacent(tail, [head | new])
    end
  end

  def remove_polymer(input, char) do
    {:ok, regex} =
      Regex.compile("[#{String.downcase(to_string([char]))}#{String.upcase(to_string([char]))}]")

    Regex.replace(regex, input, "")
  end
end
