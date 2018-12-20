defmodule AdventTest.Day6Test do
  use ExUnit.Case

  describe "Day 6 - part 1" do
    test "part 1" do
      assert Advent.Day6.part_1([{1, 1}, {1, 6}, {8, 3}, {3, 4}, {5, 5}, {8, 9}]) == 17
    end

    test "find_largest" do
      assert Advent.Day6.find_largest([{1, 1}, {1, 6}, {8, 3}, {3, 4}, {5, 5}, {8, 9}]) == {8, 9}
      assert Advent.Day6.find_largest([{1, 31}, {150, 18}, {80, 93}, {84, 9}]) == {150, 93}
    end

    test "create_grid" do
      assert Advent.Day6.create_grid({2, 3}) == [
               [{0, 0}, {1, 0}, {2, 0}],
               [{0, 1}, {1, 1}, {2, 1}],
               [{0, 2}, {1, 2}, {2, 2}],
               [{0, 3}, {1, 3}, {2, 3}]
             ]

      assert Advent.Day6.create_grid({8, 9}) ==
               [
                 [{0, 0}, {1, 0}, {2, 0}, {3, 0}, {4, 0}, {5, 0}, {6, 0}, {7, 0}, {8, 0}],
                 [{0, 1}, {1, 1}, {2, 1}, {3, 1}, {4, 1}, {5, 1}, {6, 1}, {7, 1}, {8, 1}],
                 [{0, 2}, {1, 2}, {2, 2}, {3, 2}, {4, 2}, {5, 2}, {6, 2}, {7, 2}, {8, 2}],
                 [{0, 3}, {1, 3}, {2, 3}, {3, 3}, {4, 3}, {5, 3}, {6, 3}, {7, 3}, {8, 3}],
                 [{0, 4}, {1, 4}, {2, 4}, {3, 4}, {4, 4}, {5, 4}, {6, 4}, {7, 4}, {8, 4}],
                 [{0, 5}, {1, 5}, {2, 5}, {3, 5}, {4, 5}, {5, 5}, {6, 5}, {7, 5}, {8, 5}],
                 [{0, 6}, {1, 6}, {2, 6}, {3, 6}, {4, 6}, {5, 6}, {6, 6}, {7, 6}, {8, 6}],
                 [{0, 7}, {1, 7}, {2, 7}, {3, 7}, {4, 7}, {5, 7}, {6, 7}, {7, 7}, {8, 7}],
                 [{0, 8}, {1, 8}, {2, 8}, {3, 8}, {4, 8}, {5, 8}, {6, 8}, {7, 8}, {8, 8}],
                 [{0, 9}, {1, 9}, {2, 9}, {3, 9}, {4, 9}, {5, 9}, {6, 9}, {7, 9}, {8, 9}]
               ]
    end

    test "find closest point" do
      assert Advent.Day6.find_closest_point(
               [
                 [{0, 0}, {1, 0}, {2, 0}],
                 [{0, 1}, {1, 1}, {2, 1}],
                 [{0, 2}, {1, 2}, {2, 2}],
                 [{0, 3}, {1, 3}, {2, 3}]
               ],
               [{0, 1}, {1, 2}, {2, 3}]
             ) == [[0, nil, nil], [0, nil, nil], [nil, 1, nil], [nil, nil, 2]]

      assert Advent.Day6.find_closest_point(
               [
                 [{0, 0}, {1, 0}, {2, 0}, {3, 0}, {4, 0}, {5, 0}, {6, 0}, {7, 0}, {8, 0}],
                 [{0, 1}, {1, 1}, {2, 1}, {3, 1}, {4, 1}, {5, 1}, {6, 1}, {7, 1}, {8, 1}],
                 [{0, 2}, {1, 2}, {2, 2}, {3, 2}, {4, 2}, {5, 2}, {6, 2}, {7, 2}, {8, 2}],
                 [{0, 3}, {1, 3}, {2, 3}, {3, 3}, {4, 3}, {5, 3}, {6, 3}, {7, 3}, {8, 3}],
                 [{0, 4}, {1, 4}, {2, 4}, {3, 4}, {4, 4}, {5, 4}, {6, 4}, {7, 4}, {8, 4}],
                 [{0, 5}, {1, 5}, {2, 5}, {3, 5}, {4, 5}, {5, 5}, {6, 5}, {7, 5}, {8, 5}],
                 [{0, 6}, {1, 6}, {2, 6}, {3, 6}, {4, 6}, {5, 6}, {6, 6}, {7, 6}, {8, 6}],
                 [{0, 7}, {1, 7}, {2, 7}, {3, 7}, {4, 7}, {5, 7}, {6, 7}, {7, 7}, {8, 7}],
                 [{0, 8}, {1, 8}, {2, 8}, {3, 8}, {4, 8}, {5, 8}, {6, 8}, {7, 8}, {8, 8}],
                 [{0, 9}, {1, 9}, {2, 9}, {3, 9}, {4, 9}, {5, 9}, {6, 9}, {7, 9}, {8, 9}]
               ],
               [{1, 1}, {1, 6}, {8, 3}, {3, 4}, {5, 5}, {8, 9}]
             ) == [
               [0, 0, 0, 0, 0, nil, 2, 2, 2],
               [0, 0, 0, 0, 0, nil, 2, 2, 2],
               [0, 0, 0, 3, 3, 4, 2, 2, 2],
               [0, 0, 3, 3, 3, 4, 2, 2, 2],
               [nil, nil, 3, 3, 3, 4, 4, 2, 2],
               [1, 1, nil, 3, 4, 4, 4, 4, 2],
               [1, 1, 1, nil, 4, 4, 4, 4, nil],
               [1, 1, 1, nil, 4, 4, 4, 5, 5],
               [1, 1, 1, nil, 4, 4, 5, 5, 5],
               [1, 1, 1, nil, 5, 5, 5, 5, 5]
             ]
    end

    test "manhattan distance" do
      assert Advent.Day6.manhattan_distance({0, 0}, {0, 1}) == 1
      assert Advent.Day6.manhattan_distance({0, 1}, {1, 2}) == 2
      assert Advent.Day6.manhattan_distance({0, 1}, {2, 2}) == 3
      assert Advent.Day6.manhattan_distance({0, 0}, {2, 2}) == 4
    end

    test "count points" do
      assert Advent.Day6.count_points(
               [[0, nil, nil], [0, nil, nil], [nil, 1, nil], [nil, nil, 2]],
               [{0, 1}, {1, 2}, {2, 3}]
             ) == [2, 1, 1]
    end
  end
end