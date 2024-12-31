defmodule Day8 do
  def part1(input) do
    {x_size, y_size, grid} = parse(input)
    visible_trees(x_size, y_size, grid) |> IO.inspect()
  end

  def part2(input) do
    {x_size, y_size, grid} = parse(input)
    scenic_score(x_size, y_size, grid) |> Enum.max() |> IO.inspect()
  end

  defp parse(input) do
    lines = input |> String.split("\n")
    y_size = length(lines)
    x_size = String.length(Enum.at(lines, 0))

    parsed =
      Enum.map(lines, fn line -> line |> String.graphemes() |> Enum.map(&String.to_integer/1) end)

    grid =
      for {line, y} <- Enum.with_index(parsed), {value, x} <- Enum.with_index(line), into: %{} do
        {{x, y}, value}
      end

    {x_size, y_size, grid}
  end

  defp visible_trees(x_size, y_size, grid) do
    for x <- 0..(x_size - 1),
        y <- 0..(y_size - 1),
        Enum.any?([{0, -1}, {0, 1}, {-1, 0}, {1, 0}], &visible?(grid[{x, y}], grid, {x, y}, &1)),
        reduce: 0 do
      acc ->
        acc + 1
    end
  end

  defp visible?(ht, grid, {x, y}, {dx, dy}) do
    case grid[{x + dx, y + dy}] do
      nil -> true
      h when h >= ht -> false
      _ -> visible?(ht, grid, {x + dx, y + dy}, {dx, dy})
    end
  end

  defp scenic_score(x_size, y_size, grid) do
    for x <- 0..(x_size - 1),
        y <- 0..(y_size - 1) do
      for dir <- [{0, -1}, {0, 1}, {-1, 0}, {1, 0}], reduce: 1 do
        acc -> acc * distance(grid[{x, y}], grid, {x, y}, dir)
      end
    end
  end

  defp distance(ht, grid, {x, y}, {dx, dy}, dist \\ 0) do
    case grid[{x + dx, y + dy}] do
      nil -> dist
      h when h >= ht -> dist + 1
      _ -> distance(ht, grid, {x + dx, y + dy}, {dx, dy}, dist + 1)
    end
  end
end

File.read!('lib/day8/input.txt') |> Day8.part1()
File.read!('lib/day8/input.txt') |> Day8.part2()
