defmodule Advent.Day1 do
  def calculate(part, input) do
    input =
      File.read!(input)
      |> String.split("\n")

    case part do
      1 -> part_1(input)
      2 -> part_2(input)
    end
  end

  def part_1(input) do
    input
    |> apply_changes(MapSet.new(), 0)
    |> elem(1)
  end

  def part_2(input) do
    find_repeat(input, MapSet.new(), 0)
  end

  def apply_changes(changes, freq_list, init_freq) do
    Enum.reduce(changes, {freq_list, init_freq, nil}, fn s, {acc_list, acc, repeat} ->
      updated_freq_list = MapSet.put(acc_list, acc)

      repeat =
        cond do
          MapSet.equal?(acc_list, updated_freq_list) && is_nil(repeat) -> acc
          true -> repeat
        end

      case s do
        "+" <> num -> {updated_freq_list, acc + String.to_integer(num), repeat}
        "-" <> num -> {updated_freq_list, acc - String.to_integer(num), repeat}
      end
    end)
  end

  def find_repeat(changes, init_freq_list, init_freq) do
    apply_changes(changes, init_freq_list, init_freq)
    |> case do
      {freq_list, freq, nil} -> find_repeat(changes, freq_list, freq)
      {_, _, repeat} -> repeat
    end
  end
end
