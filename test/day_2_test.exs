defmodule AdventTest.Day2Test do
  use ExUnit.Case

  describe "Day 2 - part 1" do
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

  describe "Day 2 - part 2" do
    test "difference" do
      assert Advent.Day2.difference("abc", "abc") == []
      assert Advent.Day2.difference("abd", "abc") == [{"d", 2}]

      assert Advent.Day2.difference("qwert", "asdfg") == [
               {"q", 0},
               {"w", 1},
               {"e", 2},
               {"r", 3},
               {"t", 4}
             ]
    end

    test "find similar" do
      assert Advent.Day2.find_similar(["abc", "abd"]) == {"abc", "abd", 2}
      assert Advent.Day2.find_similar(["adc", "abd"]) == nil
      assert Advent.Day2.find_similar(["hudkfh", "hudkfb", "hudfff"]) == {"hudkfh", "hudkfb", 5}
      assert Advent.Day2.find_similar(["hudffd", "saduhi", "dsbhdf"]) == nil

      assert Advent.Day2.find_similar([
               "abcde",
               "fghij",
               "klmno",
               "pqrst",
               "fguij",
               "axcye",
               "wvxyz"
             ]) == {"fghij", "fguij", 2}
    end

    test "part 2" do
      assert Advent.Day2.part_2(["abc", "abd"]) == "ab"
      assert Advent.Day2.part_2(["adc", "abd"]) == nil
      assert Advent.Day2.part_2(["hudkfh", "hudkfb", "hudfff"]) == "hudkf"
      assert Advent.Day2.part_2(["hudffd", "saduhi", "dsbhdf"]) == nil

      assert Advent.Day2.part_2([
               "abcde",
               "fghij",
               "klmno",
               "pqrst",
               "fguij",
               "axcye",
               "wvxyz"
             ]) == "fgij"
    end
  end
end
