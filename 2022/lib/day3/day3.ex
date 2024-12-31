defmodule AOC22.Day3 do
  def part1(input) do
    input
    |> String.split("\n")
    # halves
    |> Enum.map(&String.split_at(&1, div(String.length(&1), 2)))
    |> Enum.map(fn {x, y} ->
      MapSet.intersection(MapSet.new(String.graphemes(x)), MapSet.new(String.graphemes(y)))
    end)
    |> Enum.map(&MapSet.to_list/1)
    |> Enum.map(&Enum.at(&1, 0))
    |> Enum.map(fn <<ch>> ->
      cond do
        ?A <= ch and ch <= ?Z -> ch - ?A + 1 + 26
        ?a <= ch and ch <= ?z -> ch - ?a + 1
      end
    end)
    |> Enum.sum()
    |> IO.inspect()
  end

  def part2(input) do
    input
    |> String.split("\n")
    |> Enum.chunk_every(3)
    |> Enum.map(&List.to_tuple/1)
    |> Enum.map(fn {x, y, z} ->
      a = MapSet.new(String.graphemes(x))
      b = MapSet.new(String.graphemes(y))
      c = MapSet.new(String.graphemes(z))

      ab = MapSet.intersection(a, b)
      MapSet.intersection(ab, c)
    end)
    |> Enum.map(&MapSet.to_list/1)
    |> Enum.map(&Enum.at(&1, 0))
    |> Enum.map(fn <<ch>> ->
      cond do
        ?A <= ch and ch <= ?Z -> ch - ?A + 1 + 26
        ?a <= ch and ch <= ?z -> ch - ?a + 1
      end
    end)
    |> Enum.sum()
    |> IO.inspect()
  end
end

File.read!('lib/day3/input.txt') |> AOC22.Day3.part1()
File.read!('lib/day3/input.txt') |> AOC22.Day3.part2()
