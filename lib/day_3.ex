defmodule Advent.Day3 do
  def calculate(part, input) do
    input =
      File.read!(input)
      |> String.split("\n")

    apply(__MODULE__, String.to_existing_atom("part_" <> to_string(part)), [input])
  end

  def part_1(input) do
    input
    |> get_size()
    |> create_fabric()
    |> place_claims(input)
    |> count_overlaps()
  end

  def get_size(input) do
    Enum.reduce(input, 0, fn c, acc ->
      {_, x_offset, y_offset, x_length, y_length} = parse_claim(c)

      x = x_offset + x_length
      y = y_offset + y_length

      cond do
        x > acc and x >= y -> x
        y > acc and y >= x -> y
        true -> acc
      end
    end)
  end

  def parse_claim(claim) do
    [id, measurement_string] = String.split(claim, "@") |> Enum.map(&String.trim/1)

    [offsets, lengths] = String.split(measurement_string, ":") |> Enum.map(&String.trim/1)

    [x_offset, y_offset] = offsets |> String.split(",") |> Enum.map(&String.to_integer/1)
    [x_length, y_length] = lengths |> String.split("x") |> Enum.map(&String.to_integer/1)

    {id, x_offset, y_offset, x_length, y_length}
  end

  def create_fabric(size) do
    nil |> List.duplicate(size) |> List.duplicate(size)
  end

  def place_claims(fabric, input) do
    Enum.reduce(input, fabric, fn c, acc ->
      {id, x_offset, y_offset, x_length, y_length} = parse_claim(c)

      Enum.with_index(acc)
      |> Enum.map(fn {r, i} ->
        cond do
          i in y_offset..(y_offset + y_length - 1) -> claim(r, x_offset, x_length, id)
          true -> r
        end
      end)
    end)
  end

  def claim(row, x_offset, x_length, id) do
    Enum.with_index(row)
    |> Enum.map(fn {c, i} ->
      cond do
        i in x_offset..(x_offset + x_length - 1) and is_nil(c) -> id
        i in x_offset..(x_offset + x_length - 1) -> :overlap
        true -> c
      end
    end)
  end

  def count_overlaps(fabric) do
    Enum.reduce(fabric, 0, fn r, acc ->
      acc + Enum.count(r, fn c -> c == :overlap end)
    end)
  end
end
