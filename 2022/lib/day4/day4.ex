defmodule AOC22.Day4 do
  def part1(input) do
    input
    |> String.split("\n")
    |> Enum.map(&String.split(&1, ","))
    |> Enum.map(&List.to_tuple/1)
    |> Enum.map(fn {x, y} ->
      {String.split(x, "-") |> Enum.map(&String.to_integer/1) |> List.to_tuple(),
       String.split(y, "-") |> Enum.map(&String.to_integer/1) |> List.to_tuple()}
    end)
    |> Enum.filter(fn x -> complete_overlap?(x) end)
    |> length()
    |> IO.inspect()
  end

  def complete_overlap({{a1, b1}, {a2, b2}}) do
    (a1 <= a2 and b1 >= b2) or (a1 >= a2 and b1 <= b2)
  end

  def part2(input) do
    input
    |> String.split("\n")
    |> Enum.map(&String.split(&1, ","))
    |> Enum.map(&List.to_tuple/1)
    |> Enum.map(fn {x, y} ->
      {String.split(x, "-") |> Enum.map(&String.to_integer/1) |> List.to_tuple(),
       String.split(y, "-") |> Enum.map(&String.to_integer/1) |> List.to_tuple()}
    end)
    |> Enum.reject(&no_overlap_at_all?/1)
    |> length()
    |> IO.inspect()
  end

  def no_overlap_at_all?({{a1, b1}, {a2, b2}}) do
    b1 < a2 or b2 < a1
  end
end

File.read!('lib/day4/input.txt') |> AOC22.Day4.part1()
File.read!('lib/day4/input.txt') |> AOC22.Day4.part2()
