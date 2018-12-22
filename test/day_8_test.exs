defmodule AdventTest.Day8Test do
  use ExUnit.Case

  @input ["2", "3", "0", "3", "10", "11", "12", "1", "1", "0", "1", "99", "2", "1", "1", "2"]

  describe "Day 8 - part 1" do
    test "part 1" do
      assert Advent.Day8.part_1(@input) == 138
    end

    test "create tree" do
      assert Advent.Day8.create_tree(Enum.slice(@input, 2..-1)) ==
               {["1", "1", "0", "1", "99", "2", "1", "1", "2"],
                %{num_children: "0", num_meta: "3", children: [], meta: ["10", "11", "12"]}}

      assert Advent.Day8.create_tree(@input) ==
               {[],
                %{
                  num_children: "2",
                  num_meta: "3",
                  children: [
                    %{
                      num_children: "0",
                      num_meta: "3",
                      children: [],
                      meta: ["10", "11", "12"]
                    },
                    %{
                      num_children: "1",
                      num_meta: "1",
                      children: [
                        %{
                          num_children: "0",
                          num_meta: "1",
                          children: [],
                          meta: ["99"]
                        }
                      ],
                      meta: ["2"]
                    }
                  ],
                  meta: ["1", "1", "2"]
                }}
    end
  end
end
