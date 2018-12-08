defmodule Advent.Day2 do
  def calculate(part, input) do
    input =
      File.read!(input)
      |> String.split("\n")

    case part do
      1 -> part_1(input)
      2 -> part_2(input)
    end
  end

  def part_1(input) do
    count_chars(input, 2) * count_chars(input, 3)
  end

  def part_2(input) do
    case find_similar(input) do
      {str_1, _str_2, i} ->
        String.slice(str_1, 0..(i - 1)) <> String.slice(str_1, (i + 1)..String.length(str_1))

      nil ->
        nil
    end
  end

  def count_chars(input, count) do
    Enum.reduce(input, 0, fn id, acc ->
      case id |> String.split("", trim: true) |> has_element_n_times?(count) do
        true -> acc + 1
        false -> acc
      end
    end)
  end

  def has_element_n_times?(list, count) do
    list
    |> (fn l -> Enum.group_by(l, fn e -> Enum.count(l, &(e == &1)) end) end).()
    |> Map.has_key?(count)
  end

  def difference(str_1, str_2) do
    str_1
    |> String.split("", trim: true)
    |> Enum.with_index()
    |> Enum.filter(fn {c, i} -> String.at(str_2, i) != c end)
  end

  def find_similar([]), do: nil

  def find_similar([head | tail]) do
    case Enum.reduce_while(tail, nil, fn s, acc ->
           case difference(head, s) do
             diff when is_list(diff) and length(diff) == 1 ->
               {:halt, {head, s, diff |> List.first() |> elem(1)}}

             _ ->
               {:cont, acc}
           end
         end) do
      nil -> find_similar(tail)
      similar -> similar
    end
  end
end
