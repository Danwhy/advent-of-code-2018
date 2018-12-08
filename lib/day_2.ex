defmodule Advent.Day2 do
  def calculate(part, input) do
    input =
      File.read!(input)
      |> String.split("\n")

    case part do
      1 -> part_1(input)
    end
  end

  def part_1(input) do
    count_chars(input, 2) * count_chars(input, 3)
  end

  def count_chars(input, count) do
    Enum.reduce(input, 0, fn id, acc ->
      case id |> String.split("", trim: true) |> has_element_n_times?(count) do
        true -> acc + 1
        false -> acc
      end
    end)
  end

  def has_element_n_times?(list, count) do
    list
    |> (fn l -> Enum.group_by(l, fn e -> Enum.count(l, &(e == &1)) end) end).()
    |> Map.has_key?(count)
  end
end
