defmodule Advent.Day6 do
  def calculate(part, input) do
    input =
      File.read!(input)
      |> String.split("\n")
      |> Enum.map(fn s ->
        String.split(s, ", ") |> Enum.map(&String.to_integer/1) |> List.to_tuple()
      end)

    apply(__MODULE__, String.to_existing_atom("part_" <> to_string(part)), [input])
  end

  def part_1(input) do
    grid =
      input
      |> find_largest()
      |> create_grid()
      |> find_closest_point(input)

    infinites =
      grid
      |> find_infinites()

    grid
    |> count_points(input)
    |> Enum.with_index()
    |> Enum.filter(fn {_p, i} -> i not in infinites end)
    |> Enum.max_by(fn {v, _i} -> v end)
    |> elem(0)
  end

  def part_2(input, proximity \\ 10_000) do
    input
    |> find_largest()
    |> create_grid()
    |> find_distances(input)
    |> find_within_proximity(proximity)
  end

  def find_largest(input) do
    Enum.reduce(input, {0, 0}, fn {x, y}, {acc_x, acc_y} ->
      cond do
        x >= acc_x && y >= acc_y -> {x, y}
        x < acc_x && y >= acc_y -> {acc_x, y}
        x >= acc_x && y < acc_y -> {x, acc_y}
        true -> {acc_x, acc_y}
      end
    end)
  end

  def create_grid({x, y}) do
    List.duplicate(nil, x + 1)
    |> Enum.with_index()
    |> Enum.map(fn {nil, x} -> x end)
    |> List.duplicate(y + 1)
    |> Enum.with_index()
    |> Enum.map(fn {l, i} -> Enum.map(l, fn x -> {x, i} end) end)
  end

  def find_closest_point(grid, input) do
    Enum.map(grid, fn l ->
      Enum.map(l, fn coord ->
        input
        |> Enum.with_index()
        |> Enum.reduce({nil, nil}, fn {c, i}, {i_acc, md_acc} ->
          case manhattan_distance(c, coord) do
            md when md < md_acc -> {i, md}
            md when md == md_acc -> {nil, md}
            md when md > md_acc -> {i_acc, md_acc}
          end
        end)
        |> elem(0)
      end)
    end)
  end

  def manhattan_distance({x1, y1}, {x2, y2}) do
    abs(x1 - x2) + abs(y1 - y2)
  end

  def count_points(grid, input) do
    Enum.reduce(grid, List.duplicate(0, length(input)), fn r, acc ->
      Enum.reduce(r, acc, fn c, r_acc ->
        case c do
          nil -> r_acc
          c -> List.update_at(r_acc, c, &(&1 + 1))
        end
      end)
    end)
  end

  def find_infinites(grid) do
    excludes = List.first(grid) ++ List.last(grid)

    grid
    |> Enum.reduce(excludes, fn r, acc ->
      acc = [List.first(r) | acc]
      [List.last(r) | acc]
    end)
    |> Enum.uniq()
  end

  def find_distances(grid, input) do
    Enum.map(grid, fn row ->
      Enum.map(row, fn {x, y} ->
        Enum.reduce(input, 0, fn c, acc ->
          acc + manhattan_distance(c, {x, y})
        end)
      end)
    end)
  end

  def find_within_proximity(grid, proximity) do
    Enum.reduce(grid, 0, fn row, acc ->
      Enum.reduce(row, acc, fn p, r_acc ->
        if p < proximity, do: r_acc + 1, else: r_acc
      end)
    end)
  end
end
