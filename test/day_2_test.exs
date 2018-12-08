defmodule AdventTest.Day2Test do
  use ExUnit.Case

  describe "Day 2" do
    test "has element n times?" do
      assert Advent.Day2.has_element_n_times?(["a", "b", "b", "c", "d", "e"], 2)
      refute Advent.Day2.has_element_n_times?(["a", "b", "b", "c", "d", "e"], 3)
      assert Advent.Day2.has_element_n_times?(["d", "f", "f", "d", "f"], 2)
      assert Advent.Day2.has_element_n_times?(["d", "f", "f", "d", "f"], 3)
    end

    test "count chars" do
      assert Advent.Day2.count_chars(["abcdef"], 2) == 0
      assert Advent.Day2.count_chars(["bababc"], 2) == 1
      assert Advent.Day2.count_chars(["abcdef", "bababc"], 2) == 1

      assert Advent.Day2.count_chars(
               ["abcdef", "bababc", "abbcde", "abcccd", "aabcdd", "abcdee", "ababab"],
               2
             ) == 4
    end

    test "part 1" do
      assert Advent.Day2.part_1([
               "abcdef",
               "bababc",
               "abbcde",
               "abcccd",
               "aabcdd",
               "abcdee",
               "ababab"
             ]) == 12

      assert Advent.Day2.part_1([
               "merry",
               "mepoi",
               "gusud",
               "dvded",
               "dffdf"
             ]) == 6
    end
  end
end
