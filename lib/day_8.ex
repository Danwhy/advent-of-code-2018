defmodule Advent.Day8 do
  def calculate(part, input) do
    input =
      File.read!(input)
      |> String.split(" ")

    apply(__MODULE__, String.to_existing_atom("part_" <> to_string(part)), [input])
  end

  def part_1(input) do
    input
    |> create_tree()
    |> elem(1)
    |> add_metadata(0)
  end

  def create_tree([num_children | [num_meta | tail]]) do
    node = create_node(num_children, num_meta)

    List.duplicate(nil, String.to_integer(num_children))
    |> Enum.reduce({tail, node}, fn _, {acc_t, acc_n} ->
      {new_tail, child} = create_tree(acc_t)

      {new_tail, Map.update!(acc_n, :children, fn c -> List.insert_at(c, -1, child) end)}
    end)
    |> (fn {new_tail, new_node} ->
          {meta, rest} = Enum.split(new_tail, String.to_integer(num_meta))

          {rest, Map.update!(new_node, :meta, fn c -> c ++ meta end)}
        end).()
  end

  def create_node(num_children, num_meta) do
    %{
      num_children: num_children,
      num_meta: num_meta,
      children: [],
      meta: []
    }
  end

  def add_metadata(tree, count) do
    Enum.reduce(tree, count, fn {k, v}, acc ->
      case k do
        :meta -> Enum.reduce(v, acc, &(String.to_integer(&1) + &2))
        :children -> Enum.reduce(v, acc, &add_metadata(&1, &2))
        _ -> acc
      end
    end)
  end
end
