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
    init_board = CircularList.new([0])
    init_players = List.duplicate(0, num_players)

    Enum.reduce(1..points, {init_board, init_players}, fn p, {board, players} ->
      place_next_marble(board, players, p)
    end)
  end

  def place_next_marble(board, players, next_marble) do
    case Integer.mod(next_marble, 23) do
      0 ->
        board = Enum.reduce(1..7, board, fn _, board -> CircularList.previous(board) end)

        {CircularList.delete(board), update_scores(players, next_marble, CircularList.get(board))}

      _ ->
        {board |> CircularList.next() |> CircularList.next() |> CircularList.insert(next_marble),
         players}
    end
  end

  def update_scores(players, next_marble, value_to_remove) do
    List.update_at(
      players,
      Integer.mod(next_marble, length(players)) - 1,
      &(&1 + next_marble + value_to_remove)
    )
  end
end

defmodule CircularList do
  @doc """
  Creates a new circular list
  ## Examples

      iex> CircularList.new([])
      {[], []}

      iex> CircularList.new([1, 2, 3])
      {[], [1, 2, 3]}
  """
  def new(list \\ []), do: {[], list}

  @doc """
  Returns the current element.

  ## Examples

      iex> CircularList.get({[], []})
      nil

      iex> CircularList.get({[], [1, 2, 3]})
      1
  """
  def get({_, [head | _]}), do: head
  def get({[], []}), do: nil

  @doc """
  Moves to the next element.

  ## Examples

      iex> list = CircularList.new([1, 2, 3])
      ...> CircularList.next(list)
      {[1], [2, 3]}

      iex> list = CircularList.new([1, 2, 3])
      ...>   CircularList.next(list) |> CircularList.next()
      {[2, 1], [3]}

      iex> list = CircularList.new([1, 2, 3])
      ...>   CircularList.next(list) |> CircularList.next() |> CircularList.next() |> CircularList.next()
      {[1], [2, 3]}

      iex> list = CircularList.new([1, 2, 3])
      ...>   CircularList.next(list) |> CircularList.get()
      2

      iex> list = CircularList.new([1, 2, 3])
      ...>   CircularList.next(list) |> CircularList.next() |> CircularList.get()
      3

      iex> list = CircularList.new([1, 2, 3])
      ...>   CircularList.next(list) |> CircularList.next() |> CircularList.next() |> CircularList.get()
      1
  """
  def next({visited, [head | []]}), do: {[], Enum.reverse([head | visited])}
  def next({visited, [head | remaining]}), do: {[head | visited], remaining}

  @doc """
  Moves to the previous element.

  ## Examples

      iex> list = CircularList.new([1, 2, 3])
      ...> CircularList.previous(list)
      {[2, 1], [3]}

      iex> list = CircularList.new([1, 2, 3])
      ...>   CircularList.previous(list) |> CircularList.previous()
      {[1], [2, 3]}

      iex> list = CircularList.new([1, 2, 3])
      ...>   CircularList.previous(list) |> CircularList.get()
      3

      iex> list = CircularList.new([1, 2, 3])
      ...>   CircularList.previous(list) |> CircularList.previous() |> CircularList.get()
      2

      iex> list = CircularList.new([1, 2, 3])
      ...>   CircularList.previous(list) |> CircularList.previous() |> CircularList.previous() |> CircularList.get()
      1
  """
  def previous({[head | visited], remaining}), do: {visited, [head | remaining]}

  def previous({[], remaining}) do
    [head | tail] = Enum.reverse(remaining)
    {tail, [head]}
  end

  @doc """
  Inserts an element in the current position.

  ## Examples

      iex> list = CircularList.new([1, 2, 3])
      ...> CircularList.insert(list, 5)
      {[], [5, 1, 2, 3]}

      iex> list = CircularList.new([1, 2, 3])
      ...>   CircularList.next(list) |> CircularList.insert(5)
      {[1], [5, 2, 3]}

      iex> list = CircularList.new([1, 2, 3])
      ...>   CircularList.insert(list, 5) |> CircularList.get()
      5

      iex> list = CircularList.new([1, 2, 3])
      ...>   CircularList.insert(list, 5) |> CircularList.next() |> CircularList.get()
      1
  """
  def insert({visited, remaining}, element), do: {visited, [element | remaining]}

  @doc """
  Deletes the element in the current position.

  ## Examples

      iex> list = CircularList.new([1, 2, 3])
      ...> CircularList.delete(list)
      {[], [2, 3]}

      iex> list = CircularList.new([1, 2, 3])
      ...>   CircularList.next(list) |> CircularList.delete()
      {[1], [3]}

      iex> list = CircularList.new([1, 2, 3])
      ...>   CircularList.delete(list) |> CircularList.get()
      2

      iex> list = CircularList.new([1, 2, 3])
      ...>   CircularList.next(list) |> CircularList.delete() |> CircularList.get()
      3
  """
  def delete({visited, [_ | remaining]}), do: {visited, remaining}
end
