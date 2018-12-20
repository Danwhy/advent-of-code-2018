defmodule Advent.Day7 do
  def calculate(part, input) do
    input =
      File.read!(input)
      |> String.split("\n")

    apply(__MODULE__, String.to_existing_atom("part_" <> to_string(part)), [input])
  end

  def part_1(input) do
    input
    |> create_dependencies()
    |> process_dependencies("")
  end

  def create_dependencies(input) do
    Enum.reduce(input, %{}, fn i, acc ->
      left = String.at(i, 5)
      right = String.at(i, 36)

      acc
      |> Map.put_new(left, MapSet.new())
      |> Map.update(right, MapSet.new([left]), fn deps -> MapSet.put(deps, left) end)
    end)
  end

  def process_dependencies(input, acc) do
    processed_input =
      case String.last(acc) do
        nil ->
          input

        dep ->
          Enum.map(input, fn {k, v} ->
            if MapSet.member?(v, dep), do: {k, MapSet.delete(v, dep)}, else: {k, v}
          end)
      end

    processed_input
    |> Enum.find(fn {_k, v} ->
      MapSet.size(v) == 0
    end)
    |> case do
      nil ->
        acc

      {k, _v} ->
        processed_input
        |> Enum.into(%{})
        |> Map.delete(k)
        |> process_dependencies(acc <> k)
    end
  end
end
