defmodule Advent.Day13 do
  require IEx

  def calculate(part, input) do
    input = input |> File.read!()

    apply(__MODULE__, String.to_existing_atom("part_" <> to_string(part)), [input])
  end

  def part_1(input) do
    input
    |> parse_input()
    |> simulate()
  end

  def part_2(input) do
    input
    |> parse_input()
    |> simulate_with_magic()
  end

  def parse_input(input) do
    input
    |> String.split("\n", trim: true)
    |> Enum.with_index()
    |> Enum.reduce(%{track: [], carts: []}, fn {r, i}, %{track: track, carts: carts} ->
      row = String.split(r, "", trim: true)

      %{
        track: List.insert_at(track, -1, remove_carts(row)),
        carts: find_carts(row |> Enum.with_index(), carts, i)
      }
    end)
  end

  def find_carts(row, carts, y_index) do
    directions = %{"^" => :north, ">" => :east, "v" => :south, "<" => :west}

    case Enum.filter(row, fn {c, _} -> c in ["v", ">", "<", "^"] end) do
      [] ->
        carts

      found ->
        Enum.reduce(found, carts, fn {dir, index}, acc ->
          List.insert_at(acc, -1, {index, y_index, Map.get(directions, dir), :left})
        end)
    end
  end

  def remove_carts(row) do
    Enum.reduce(["^", "v", ">", "<"], row, fn dir, r ->
      Enum.map(r, fn track ->
        cond do
          dir == track && dir in ["v", "^"] -> "|"
          dir == track && dir in [">", "<"] -> "-"
          true -> track
        end
      end)
    end)
  end

  def simulate(state) do
    new_state = state |> tick()

    new_state
    |> case do
      {x, y} -> {x, y}
      ok_state -> simulate(ok_state)
    end
  end

  def simulate_with_magic(state) do
    new_state = state |> tick(true)

    new_state
    |> case do
      %{carts: [{x, y, _, _}]} -> {x, y}
      ok_state -> simulate_with_magic(ok_state)
    end
  end

  def tick(state, magic \\ false) do
    state
    |> Map.get(:carts)
    |> Enum.sort_by(fn {_x, y, _, _} -> y end)
    |> Enum.reduce_while({[], []}, fn {x, y, _, _} = cart, {new_carts, collisions} ->
      if {x, y} in collisions do
        {:cont, {new_carts, collisions}}
      else
        new_cart =
          state
          |> get_next_position(cart)
          |> (fn c -> List.insert_at(new_carts, -1, c) end).()

        case check_collision(new_cart ++ Enum.slice(Map.get(state, :carts), length(new_cart)..-1)) do
          false ->
            {:cont, {new_cart, collisions}}

          collision ->
            case magic do
              false ->
                {:halt, collision}

              true ->
                {:cont,
                 {Enum.filter(new_carts, fn {x, y, _, _} -> collision != {x, y} end),
                  List.insert_at(collisions, -1, collision)}}
            end
        end
      end
    end)
    |> case do
      {carts, _} when is_list(carts) -> Map.put(state, :carts, carts)
      {x, y} -> {x, y}
    end
  end

  def get_next_position(state, {x, y, dir, cross}) do
    {next_x, next_y} = next_square(x, y, dir)

    case Enum.at(Map.get(state, :track), next_y) |> Enum.at(next_x) do
      track when track in ["|", "-"] ->
        {next_x, next_y, dir, cross}

      "/" ->
        case dir do
          :north -> {next_x, next_y, :east, cross}
          :east -> {next_x, next_y, :north, cross}
          :south -> {next_x, next_y, :west, cross}
          :west -> {next_x, next_y, :south, cross}
        end

      "\\" ->
        case dir do
          :north -> {next_x, next_y, :west, cross}
          :east -> {next_x, next_y, :south, cross}
          :south -> {next_x, next_y, :east, cross}
          :west -> {next_x, next_y, :north, cross}
        end

      "+" ->
        crossroad_direction(next_x, next_y, dir, cross)
    end
  end

  def check_collision(carts) do
    carts
    |> Enum.reduce_while(MapSet.new(), fn {x, y, _, _}, acc ->
      case MapSet.member?(acc, {x, y}) do
        true -> {:halt, {x, y}}
        false -> {:cont, MapSet.put(acc, {x, y})}
      end
    end)
    |> case do
      {x, y} -> {x, y}
      _ -> false
    end
  end

  def next_square(x, y, dir) do
    case dir do
      :north -> {x, y - 1}
      :east -> {x + 1, y}
      :south -> {x, y + 1}
      :west -> {x - 1, y}
    end
  end

  def crossroad_direction(x, y, dir, cross) do
    left_map = %{north: :west, east: :north, south: :east, west: :south}
    right_map = %{north: :east, east: :south, south: :west, west: :north}

    case cross do
      :left -> {x, y, Map.get(left_map, dir), :straight}
      :right -> {x, y, Map.get(right_map, dir), :left}
      :straight -> {x, y, dir, :right}
    end
  end
end
