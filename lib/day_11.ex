defmodule Advent.Day11 do
  def calculate(part, input) do
    input = input |> File.read!() |> String.to_integer()

    apply(__MODULE__, String.to_existing_atom("part_" <> to_string(part)), [input])
  end

  def part_1(input) do
    input
    |> build_grid()
    |> find_largest_power(3)
    |> elem(1)
  end

  def part_2(input) do
    input
    |> build_grid()
    |> (fn g ->
          Enum.map(1..300, fn size ->
            find_largest_power(g, size)
          end)
        end).()
    |> Enum.with_index()
    |> Enum.max_by(fn {{power, _}, _} -> power end)
  end

  def build_grid(serial) do
    List.to_tuple(
      for y <- 0..299, do: for(x <- 0..299, do: calculate_power(serial, x, y)) |> List.to_tuple()
    )
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

  def find_largest_power(grid, size) do
    Enum.reduce(0..299, {0, {nil, nil}}, fn y, acc ->
      Enum.reduce(0..299, acc, fn x, {max_power, _} = acc ->
        cond do
          x < 300 - size && y < 300 - size ->
            if (power = calculate_total_power(grid, x, y, size)) > max_power do
              {power, {x, y}}
            else
              acc
            end

          true ->
            acc
        end
      end)
    end)
  end

  def calculate_total_power(grid, x, y, size) do
    Enum.reduce(0..(size - 1), 0, fn i, acc ->
      row = elem(grid, y + i)

      Enum.reduce(0..(size - 1), acc, fn j, acc ->
        row
        |> elem(x + j)
        |> Kernel.+(acc)
      end)
    end)
  end
end
