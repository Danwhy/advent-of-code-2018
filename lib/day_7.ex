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

  def part_2(input, num_workers \\ 5) do
    input
    |> create_dependencies()
    |> assign_tasks(List.duplicate(nil, num_workers), [], [])
    |> length
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
        nil -> input
        dep -> remove_dependency(input, dep)
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

  def assign_tasks(input, _workers, time, _assigned) when input == %{}, do: time

  def assign_tasks(input, workers, time, assigned) do
    last_second = List.last(time) || workers

    {current_second, {assigned, completed}} =
      workers
      |> Enum.with_index()
      |> Enum.map_reduce({assigned, []}, fn {_w, i}, {assigned, completed} = acc ->
        case Enum.at(last_second, i) do
          x when is_nil(x) or x == :idle ->
            case get_available_task(input, assigned) do
              nil ->
                {:idle, acc}

              {new_task, _} ->
                assign_new_task(new_task, assigned, completed)
            end

          {_current_task, 0} ->
            case get_available_task(input, assigned) do
              nil ->
                {:idle, {assigned, completed}}

              {new_task, _} ->
                assign_new_task(new_task, assigned, completed)
            end

          {current_task, 1} ->
            {{current_task, 0}, {assigned, List.insert_at(completed, -1, current_task)}}

          {current_task, task_time} ->
            {{current_task, task_time - 1}, acc}
        end
      end)

    completed
    |> Enum.reduce(input, fn t, acc ->
      acc
      |> remove_dependency(t)
      |> complete_task(t)
    end)
    |> assign_tasks(workers, List.insert_at(time, -1, current_second), assigned)
  end

  def assign_new_task(new_task, assigned, completed) do
    case calculate_task_time(new_task) do
      0 ->
        {{new_task, 0},
         {List.insert_at(assigned, -1, new_task), List.insert_at(completed, -1, new_task)}}

      t ->
        {{new_task, t}, {List.insert_at(assigned, -1, new_task), completed}}
    end
  end

  def get_available_task(input, assigned) do
    find_all(input, fn {_k, v} ->
      MapSet.size(v) == 0
    end)
    |> Enum.filter(fn {t, _} ->
      t not in assigned
    end)
    |> List.first()
  end

  def calculate_task_time(task), do: (task |> String.to_charlist() |> hd) - 4 - 1

  def remove_dependency(input, task) do
    Enum.map(input, fn {k, v} ->
      if MapSet.member?(v, task), do: {k, MapSet.delete(v, task)}, else: {k, v}
    end)
  end

  def find_all(enumerable, fun) do
    Enum.reduce(enumerable, [], fn e, acc ->
      if fun.(e), do: acc ++ [e], else: acc
    end)
  end

  def complete_task(input, task) do
    input
    |> Enum.into(%{})
    |> Map.delete(task)
  end
end
