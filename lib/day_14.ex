defmodule Advent.Day14 do
  def calculate(part, input) do
    input = input |> File.read!() |> String.to_integer()

    apply(__MODULE__, String.to_existing_atom("part_" <> to_string(part)), [input])
  end

  def part_1(input) do
    input
    |> create_recipes()
    |> elem(0)
    |> (fn r ->
          Enum.reduce(0..9, "", fn i, acc ->
            acc <> to_string(Map.get(r, input + i))
          end)
        end).()
  end

  def next_recipe(recipe_length, current_score, current_pos) do
    next_pos = current_pos + current_score + 1

    rem(next_pos, recipe_length)
  end

  def create_recipes(input) do
    initial_state = {%{0 => 3, 1 => 7}, {0, 1}}

    Enum.reduce(1..(input + 6), initial_state, fn _, {recipes, {elf_1, elf_2}} ->
      recipe_score_1 = Map.get(recipes, elf_1)
      recipe_score_2 = Map.get(recipes, elf_2)
      recipe_sum = recipe_score_1 + recipe_score_2
      recipe_size = map_size(recipes)

      new_recipes =
        to_string(recipe_sum)
        |> String.split("", trim: true)
        |> Enum.map(&String.to_integer/1)

      updated_recipes =
        case new_recipes do
          [new_recipe_1, new_recipe_2] ->
            Map.put(recipes, recipe_size, new_recipe_1)
            |> Map.put(recipe_size + 1, new_recipe_2)

          [new_recipe_1] ->
            Map.put(recipes, recipe_size, new_recipe_1)
        end

      {updated_recipes,
       {next_recipe(recipe_size + length(new_recipes), recipe_score_1, elf_1),
        next_recipe(recipe_size + length(new_recipes), recipe_score_2, elf_2)}}
    end)
  end
end
