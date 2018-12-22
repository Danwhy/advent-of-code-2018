defmodule AdventTest do
  use ExUnit.Case
  doctest Advent

  describe "Solution Day 1" do
    test "Part 1" do
      assert Advent.run(:day_1) == 416
    end

    test "Part 2" do
      assert Advent.run(:day_1, 2) == 56752
    end
  end

  describe "Solution Day 2" do
    test "Part 1" do
      assert Advent.run(:day_2) == 6723
    end

    test "Part 2" do
      assert Advent.run(:day_2, 2) == "prtkqyluiusocwvaezjmhmfgx"
    end
  end

  describe "Solution Day 3" do
    test "Part 1" do
      assert Advent.run(:day_3) == 104_126
    end

    @tag timeout: 100_000, skip: "So slow"
    test "Part 2" do
      assert Advent.run(:day_3, 2) == "695"
    end
  end

  describe "Solution Day 4" do
    test "Part 1" do
      assert Advent.run(:day_4) == 72925
    end

    test "Part 2" do
      assert Advent.run(:day_4, 2) == 49137
    end
  end

  describe "Solution Day 5" do
    test "Part 1" do
      assert Advent.run(:day_5) == 9238
    end

    test "Part 2" do
      assert Advent.run(:day_5, 2) == 4052
    end
  end

  describe "Solution Day 6" do
    test "Part 1" do
      assert Advent.run(:day_6) == 4976
    end

    test "Part 2" do
      assert Advent.run(:day_6, 2) == 46462
    end
  end

  describe "Solution Day 7" do
    test "Part 1" do
      assert Advent.run(:day_7) == "ABLCFNSXZPRHVEGUYKDIMQTWJO"
    end

    test "Part 2" do
      assert Advent.run(:day_7, 2) == 1157
    end
  end

  describe "Solution Day 8" do
    test "Part 1" do
      assert Advent.run(:day_8) == 42196
    end
  end
end
