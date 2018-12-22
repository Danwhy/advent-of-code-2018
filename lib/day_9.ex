defmodule Advent.Day9 do
  def calculate(part, input) do
    input = File.read!(input)

    apply(__MODULE__, String.to_existing_atom("part_" <> to_string(part)), [input])
  end

  def part_1(input) do
    input
    |> parse_input()
    |> play_game()
    |> elem(1)
    |> Enum.max()
  end

  def part_2(input) do
    input
    |> parse_input()
    |> (fn {players, points} -> {players, points * 100} end).()
    |> play_game()
    |> elem(1)
    |> Enum.max()
  end

  def parse_input(input) do
    [left, right] = String.split(input, ";")

    num_players = String.split(left, " ") |> List.first() |> String.to_integer()

    points =
      String.split_at(right, 21)
      |> elem(1)
      |> String.split(" points")
      |> List.first()
      |> String.trim()
      |> String.to_integer()

    {num_players, points}
  end

  def play_game({num_players, points}) do
    Enum.reduce(1..points, {[0], List.duplicate(0, num_players), 0}, fn p,
                                                                        {board, players, current} ->
      place_next_marble(board, players, current, p)
    end)
  end

  def place_next_marble(board, players, current, next_marble) do
    board_length = length(board)

    case Integer.mod(next_marble, 23) do
      0 ->
        cond do
          current - 7 < 0 ->
            {List.delete_at(board, board_length - (7 - current)),
             update_scores(players, next_marble, board, board_length - (7 - current)),
             board_length - (7 - current)}

          true ->
            {List.delete_at(board, current - 7),
             update_scores(players, next_marble, board, current - 7), current - 7}
        end

      _ ->
        cond do
          current + 2 > board_length ->
            {List.insert_at(board, 1, next_marble), players, 1}

          current + 2 == board_length ->
            {List.insert_at(board, -1, next_marble), players, board_length}

          true ->
            {List.insert_at(board, current + 2, next_marble), players, current + 2}
        end
    end
  end

  def update_scores(players, next_marble, board, value_to_remove) do
    List.update_at(
      players,
      Integer.mod(next_marble, length(players)) - 1,
      &(&1 + next_marble + Enum.at(board, value_to_remove))
    )
  end
end
