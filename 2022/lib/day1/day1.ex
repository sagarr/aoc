defmodule AOC22.Day1 do
  def part1(input) do
    chunk_fun = fn x, acc ->
      if x == "" do
        {:cont, acc, []}
      else
        {:cont, [x | acc]}
      end
    end

    after_fun = fn
      [] -> {:cont, []}
      acc -> {:cont, Enum.reverse(acc), []}
    end

    input
    |> String.split("\n")
    |> Enum.chunk_while(
      [],
      chunk_fun,
      after_fun
    )
    |> Enum.map(fn x -> Enum.map(x, &String.to_integer/1) end)
    |> Enum.map(&Enum.sum(&1))
    |> Enum.max()
    |> IO.inspect()
  end

  def part2(input) do
    chunk_fun = fn x, acc ->
      if x == "" do
        {:cont, acc, []}
      else
        {:cont, [x | acc]}
      end
    end

    after_fun = fn
      [] -> {:cont, []}
      acc -> {:cont, Enum.reverse(acc), []}
    end

    input
    |> String.split("\n")
    |> Enum.chunk_while(
      [],
      chunk_fun,
      after_fun
    )
    |> Enum.map(fn x -> Enum.map(x, &String.to_integer/1) end)
    |> Enum.map(&Enum.sum(&1))
    |> Enum.sort(:desc)
    |> Enum.take(3)
    |> Enum.sum()
    |> IO.inspect()
  end
end

File.read!('lib/day1/input.txt') |> AOC22.Day1.part1(input)
File.read!('lib/day1/input.txt') |> AOC22.Day1.part2(input)
