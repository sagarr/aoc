defmodule AOC22.Day2 do
  def part1(input) do
    input
    |> String.split("\n")
    |> Enum.map(&String.split/1)
    |> Enum.map(fn [p | [q | _]] -> play(p, q) end)
    |> Enum.sum()
    |> IO.inspect()
  end

  # Rock defeats Scissors, Scissors defeats Paper, and Paper defeats Rock
  # (1 for Rock, 2 for Paper, and 3 for Scissors) plus the score for the outcome of the round
  # (0 if you lost, 3 if the round was a draw, and 6 if you won).

  defp play1("A", "X"), do: 3 + 1
  defp play1("B", "Y"), do: 3 + 2
  defp play1("C", "Z"), do: 3 + 3
  defp play1("A", "Y"), do: 6 + 2
  defp play1("B", "X"), do: 1 + 0
  defp play1("A", "Z"), do: 3 + 0
  defp play1("C", "X"), do: 1 + 6
  defp play1("B", "Z"), do: 3 + 6
  defp play1("C", "Y"), do: 2 + 0

  def part2(input) do
    input
    |> String.split("\n")
    |> Enum.map(&String.split/1)
    |> Enum.map(fn [p | [q | _]] -> play(p, q) end)
    |> Enum.sum()
    |> IO.inspect()
  end

  # X means you need to lose, Y means you need to end the round in a draw, and Z means you need to win. Good luck!"
  defp play2("A", "X"), do: 3 + 0
  defp play2("B", "Y"), do: 2 + 3
  defp play2("C", "Z"), do: 1 + 6
  defp play2("A", "Y"), do: 1 + 3
  defp play2("B", "X"), do: 1 + 0
  defp play2("A", "Z"), do: 2 + 6
  defp play2("C", "X"), do: 2 + 0
  defp play2("B", "Z"), do: 3 + 6
  defp play2("C", "Y"), do: 3 + 3
end

File.read!('lib/day2/input.txt') |> AOC22.Day2.part1(input)
File.read!('lib/day2/input.txt') |> AOC22.Day2.part2(input)
