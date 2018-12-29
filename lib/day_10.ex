defmodule Advent.Day10 do
  def calculate(part, input) do
    input = input |> File.read!() |> String.split("\n")

    apply(__MODULE__, String.to_existing_atom("part_" <> to_string(part)), [input])
  end

  def part_1(input) do
    input
    |> Enum.map(&parse_input/1)
    |> tick()
    |> render_message()
    |> (fn c -> File.write!("day_10_answer.txt", c) end).()
  end

  def part_2(input) do
    [init_x, _, x_v, _] =
      input
      |> Enum.map(&parse_input/1)
      |> List.first()

    [final_x, _, _, _] =
      input
      |> Enum.map(&parse_input/1)
      |> tick()
      |> List.first()

    (final_x - init_x) / x_v
  end

  def parse_input(input) do
    [_, x_p, y_p, _, x_v, y_v] =
      input
      |> String.split(["<", ",", ">", "<", ",", ">"], trim: true)
      |> Enum.map(&String.trim/1)

    [x_p, y_p, x_v, y_v] |> Enum.map(&String.to_integer/1)
  end

  def tick(points) do
    points
    |> Enum.map(fn [x_p, y_p, x_v, y_v] ->
      [x_p + x_v, y_p + y_v, x_v, y_v]
    end)
    |> check_alignment()
  end

  def check_alignment(points) do
    character_height = 10

    case Enum.reduce_while(points, {nil, nil, nil}, fn [_, y, _, _], {range, low, high} ->
           cond do
             range == nil ->
               {:cont, {(y - character_height)..(y + character_height), y, y}}

             y not in range ->
               {:halt, false}

             y in range && y < low ->
               {:cont, {(high - character_height)..(y + character_height), y, high}}

             y in range && y > high ->
               {:cont, {(y - character_height)..(low + character_height), low, y}}

             y in range ->
               {:cont, {range, low, high}}
           end
         end) do
      false -> tick(points)
      _ -> points
    end
  end

  def render_message(points) do
    height = points |> Enum.max_by(fn [_, y, _, _] -> y end) |> Enum.at(1)

    width = points |> Enum.max_by(fn [x, _, _, _] -> x end) |> Enum.at(0)

    row = List.duplicate(".", width + 1)

    matrix = List.duplicate(row, height + 1)

    Enum.reduce(points, matrix, fn [x, y, _, _], acc ->
      List.update_at(acc, y, fn l -> List.update_at(l, x, fn _ -> "#" end) end)
    end)
    |> Enum.flat_map(fn l -> [Enum.join(l) <> "\n"] end)
  end
end
