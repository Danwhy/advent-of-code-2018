defmodule Advent.Day12 do
  def calculate(part, input) do
    input = input |> File.read!() |> String.split("\n")

    apply(__MODULE__, String.to_existing_atom("part_" <> to_string(part)), [input])
  end

  def part_1(input, gen \\ 20) do
    input
    |> parse_input()
    |> generation(gen)
    |> gen_value()
  end

  def part_2(input, gen \\ 50_000_000_000) do
    {stable_state, stable_gen, gen_diff} =
      input
      |> parse_input()
      |> generation(gen)

    gen_value(stable_state)
    |> Kernel.+(gen_diff * (gen - stable_gen))
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
    Enum.reduce_while(1..generations, state, fn gen, acc ->
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

      next_acc =
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

      case check_cycle(acc, next_acc) do
        {true, diff} -> {:halt, {next_acc, gen, diff}}
        false -> {:cont, next_acc}
      end
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

  def check_cycle(gen, next_gen) do
    cond do
      plant_pattern(gen) |> String.replace_trailing(".", "") ==
          plant_pattern(next_gen) |> String.replace_trailing(".", "") ->
        {true, gen_value(next_gen) - gen_value(gen)}

      true ->
        false
    end
  end

  def plant_pattern(plants) do
    plants
    |> Enum.sort_by(fn {k, _} -> k end)
    |> Enum.map(fn {_, v} -> v end)
    |> Enum.with_index()
    |> Enum.reduce_while([], fn {p, i}, acc ->
      case p do
        "#" ->
          {:halt,
           Enum.sort_by(plants, fn {k, _} -> k end)
           |> Enum.map(fn {_, v} -> v end)
           |> Enum.slice(i..-1)
           |> Enum.join()}

        "." ->
          {:cont, acc}
      end
    end)
  end

  def gen_value(gen) do
    Enum.reduce(gen, 0, fn {i, p}, acc ->
      case p do
        "#" -> acc + i
        "." -> acc
      end
    end)
  end
end
