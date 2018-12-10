defmodule Advent.Day4 do
  def calculate(part, input) do
    input =
      File.read!(input)
      |> String.split("\n")

    apply(__MODULE__, String.to_existing_atom("part_" <> to_string(part)), [input])
  end

  def part_1(input) do
    report =
      input
      |> Enum.sort_by(fn r ->
        {month, day, hour, minute, _} = parse_record(r)
        month <> day <> hour <> minute
      end)
      |> create_report()

    guard =
      report
      |> total_time_asleep()
      |> Enum.max_by(fn {_id, time} -> time end)
      |> elem(0)

    minute = minute_most_slept(guard, report)

    String.to_integer(guard) * minute
  end

  def create_report(records) do
    Enum.reduce(records, [], fn r, acc ->
      {month, day, hour, minute, details} = parse_record(r)

      case details do
        "Guard" <> _ ->
          [create_guard_report(details, month, day, hour) | acc]

        "falls asleep" ->
          List.update_at(acc, 0, fn r ->
            Map.put(
              r,
              :asleep,
              r |> Map.get(:asleep) |> List.replace_at(String.to_integer(minute), true)
            )
          end)

        "wakes up" ->
          List.update_at(acc, 0, fn r ->
            fell_asleep = r |> Map.get(:asleep) |> find_last_index(& &1)

            Map.put(
              r,
              :asleep,
              r
              |> Map.get(:asleep)
              |> Enum.with_index()
              |> Enum.map(fn {a, i} ->
                if i > fell_asleep and i < String.to_integer(minute), do: true, else: a
              end)
            )
          end)
      end
    end)
  end

  def parse_record(record) do
    "[1518-" <>
      <<month::bytes-size(2)>> <>
      "-" <>
      <<day::bytes-size(2)>> <>
      " " <> <<hour::bytes-size(2)>> <> ":" <> <<minute::bytes-size(2)>> <> "] " <> details =
      record

    {month, day, hour, minute, details}
  end

  def create_guard_report(details, month, day, hour) do
    {month, day} =
      case hour do
        "23" ->
          cond do
            String.to_integer(day) == 31 or
              (String.to_integer(day) == 30 and month in ["04", "06", "09", "11"]) or
                (String.to_integer(day) == 28 and month == "02") ->
              {pad_zero(String.to_integer(month) + 1), "01"}

            true ->
              {month, day |> String.to_integer() |> Kernel.+(1) |> pad_zero()}
          end

        _ ->
          {month, day}
      end

    %{date: "#{month}-#{day}", id: get_id(details), asleep: List.duplicate(nil, 60)}
  end

  def get_id(details) do
    ~r/Guard\s#(\d+)\sbegins\sshift/
    |> Regex.run(details, capture: :all_but_first)
    |> List.first()
  end

  def find_last_index(list, func) do
    list
    |> Enum.reverse()
    |> Enum.find_index(func)
    |> (fn i -> Kernel.-(length(list) - 1, i) end).()
  end

  def total_time_asleep(report) do
    Enum.reduce(report, [], fn r, acc ->
      time_asleep = r |> Map.get(:asleep) |> Enum.count(& &1)

      if index = Enum.find_index(acc, fn {id, _time} -> id == r[:id] end) do
        List.update_at(acc, index, fn {id, time} -> {id, time + time_asleep} end)
      else
        [{Map.get(r, :id), time_asleep} | acc]
      end
    end)
  end

  def minute_most_slept(guard, report) do
    report
    |> Enum.filter(fn d -> d.id == guard end)
    |> Enum.map(&Map.get(&1, :asleep))
    |> Enum.zip()
    |> Enum.with_index()
    |> Enum.max_by(fn {a, _} ->
      a |> Tuple.to_list() |> Enum.count(& &1)
    end)
    |> elem(1)
  end

  def pad_zero(num) do
    num = to_string(num)

    case byte_size(num) do
      2 -> num
      1 -> "0" <> num
    end
  end
end
