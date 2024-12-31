defmodule Day10 do
  def part1(input) do
    cycles = input
    |> String.split("\n", trim: true)
    |> Enum.map(fn
      "noop" -> :noop
      "addx " <> v -> {:addx, elem(Integer.parse(v), 0)}
    end)
    |> Enum.reduce({[], 1}, fn
      :noop, {acc, x} -> {[[x] | acc], x}
      {:addx, n}, {acc, x} -> {[[x, x] | acc], x + n}
    end)
    |> elem(0)
    |> Enum.reverse()
    |> List.flatten()

    Enum.map([20, 60, 100, 140, 180, 220], &(Enum.at(cycles, &1 - 1) * &1)) |> Enum.sum() |> IO.inspect()

    for {s, i} <- Enum.with_index(cycles
    ) do
      if (s - rem(i, 40)) in [-1, 0, 1] do
        "#"
      else
        " "
      end
    end
    |> Enum.chunk_every(40)
    |> Enum.each(&IO.puts/1)
  end

end

File.read!('lib/day10/input.txt') |> Day10.part1()
