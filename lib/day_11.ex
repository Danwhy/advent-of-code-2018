defmodule Advent.Day11 do
  def calculate(part, input) do
    input = input |> File.read!() |> String.to_integer()

    apply(__MODULE__, String.to_existing_atom("part_" <> to_string(part)), [input])
  end

  def part_1(input) do
    input
    |> build_grid()
    |> find_largest_power()
    |> elem(2)
  end

  def build_grid(serial) do
    nil
    |> List.duplicate(300)
    |> Enum.with_index()
    |> List.duplicate(300)
    |> Enum.with_index()
    |> Enum.map(fn {row, y} ->
      {Enum.map(row, fn {_, x} -> {calculate_power(serial, x, y), x} end), y}
    end)
  end

  def calculate_power(serial, x, y) do
    rack_id = x + 10

    rack_id
    |> Kernel.*(y)
    |> Kernel.+(serial)
    |> Kernel.*(rack_id)
    |> (fn p -> p |> to_string |> String.at(-3) || 0 end).()
    |> String.to_integer()
    |> Kernel.-(5)
  end

  def find_largest_power(grid) do
    Enum.reduce(grid, {0, 0, {nil, nil}}, fn {row, y}, acc ->
      Enum.reduce(row, acc, fn {cell, x}, {_, max_power, _} = acc ->
        cond do
          x < length(row) - 3 && y < length(grid) - 3 ->
            if (power = calculate_total_power(grid, x, y)) > max_power do
              {cell, power, {x, y}}
            else
              acc
            end

          true ->
            acc
        end
      end)
    end)
  end

  def calculate_total_power(grid, x, y) do
    Enum.reduce(0..2, 0, fn i, acc ->
      row = grid |> Enum.at(y + i) |> elem(0)

      Enum.reduce(0..2, acc, fn j, acc ->
        row
        |> Enum.at(x + j)
        |> elem(0)
        |> Kernel.+(acc)
      end)
    end)
  end
end
