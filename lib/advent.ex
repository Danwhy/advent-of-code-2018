defmodule Advent do
  @moduledoc """
    Provides the run function to call each day's solution.
    Call it with the day as an atom, and the part as an integer.

        # Day 1, part 2
        Advent.run(:day_1, 2)

        # Day 4, part 1
        Advent.run(:day_4, 1)
        # or
        Advent.run(:day_4)
  """
  def run(day, part \\ 1) do
    Module.concat(Advent, day |> to_string() |> Macro.camelize()).calculate(
      part,
      "inputs/#{to_string(day)}.txt"
    )
  end
end
