defmodule Advent.Day12 do
  def calculate(part, input) do
    input = input |> File.read!() |> String.split("\n")

    apply(__MODULE__, String.to_existing_atom("part_" <> to_string(part)), [input])
  end

  def part_1(input, gen \\ 20) do
    input
    |> parse_input()
    |> generation(gen)
    |> Enum.reduce(0, fn {i, p}, acc ->
      case p do
        "#" -> acc + i
        "." -> acc
      end
    end)
  end

  def parse_input([<<"initial state: ", state::binary>> | tail]) do
    spread =
      Enum.reduce(tail, %{}, fn rule, acc ->
        case rule do
          "" -> acc
          <<rule::bytes-size(5), " => ", next::bytes-size(1)>> -> Map.put(acc, rule, next)
        end
      end)

    initial_state =
      state
      |> String.split("", trim: true)
      |> Enum.with_index()
      |> Enum.reduce(%{}, fn {s, i}, acc ->
        Map.put(acc, i, s)
      end)

    {initial_state, spread}
  end

  def generation({state, spread}, generations) do
    Enum.reduce(1..generations, state, fn _, acc ->
      indexes = Map.keys(acc) |> Enum.sort()
      first_index = List.first(indexes)
      last_index = List.last(indexes)

      acc =
        first_index
        |> (fn i -> Map.get(acc, i) end).()
        |> case do
          "#" ->
            Map.put(acc, first_index - 1, ".")
            |> Map.put(first_index - 2, ".")
            |> Map.put(first_index - 3, ".")

          "." ->
            acc
        end

      acc =
        last_index
        |> (fn i -> Map.get(acc, i) end).()
        |> case do
          "#" ->
            Map.put(acc, last_index + 1, ".")
            |> Map.put(last_index + 2, ".")
            |> Map.put(last_index + 3, ".")

          "." ->
            acc
        end

      Enum.map(acc, fn {i, _p} ->
        {i,
         match(
           [
             Map.get(acc, i - 2, nil),
             Map.get(acc, i - 1, nil),
             Map.get(acc, i, nil),
             Map.get(acc, i + 1, nil),
             Map.get(acc, i + 2, nil)
           ],
           spread
         )}
      end)
      |> Enum.into(%{})
    end)
  end

  def match(pots, spread) do
    pots =
      pots
      |> Enum.map(fn p ->
        case is_nil(p) do
          true -> "."
          _ -> p
        end
      end)
      |> Enum.join()

    Map.get(spread, pots, ".")
  end
end
