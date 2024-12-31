defmodule Day9 do
  def part1(input, knots) do
    input
    |> String.split("\n", trim: true)
    |> Enum.reduce({List.duplicate({0, 0}, knots), %{}}, fn line, {positions, grid} ->
      [dir, dist] = String.split(line, " ", trim: true)

      for _ <- 1..String.to_integer(dist), reduce: {positions, grid} do
        {positions, grid} ->
          new_positions =
            Enum.chunk_every(0..(knots - 1), 2, 1, :discard)
            |> Enum.reduce(positions, fn [x, y], acc ->
              {new_x, new_y} = move(Enum.at(acc, x), Enum.at(acc, y), dir, x == 0)
              acc |> List.replace_at(x, new_x) |> List.replace_at(y, new_y)
            end)

          updated_grid = List.last(new_positions) |> then(&Map.put(grid, &1, true))

          {new_positions, updated_grid}
      end
    end)
    |> elem(1)
    |> Enum.count()
    |> IO.inspect()
  end

  defp move({hx, hy}, {tx, ty}, dir, head?) do
    {hx, hy} =
      if head? do
        case dir do
          "U" -> {hx, hy + 1}
          "D" -> {hx, hy - 1}
          "L" -> {hx - 1, hy}
          "R" -> {hx + 1, hy}
        end
      else
        {hx, hy}
      end

    {tx, ty} =
      case {hx - tx, hy - ty} do
        {0, 2} -> {tx, ty + 1}
        {0, -2} -> {tx, ty - 1}
        {2, 0} -> {tx + 1, ty}
        {-2, 0} -> {tx - 1, ty}
        {2, 1} -> {tx + 1, ty + 1}
        {1, 2} -> {tx + 1, ty + 1}
        {1, -2} -> {tx + 1, ty - 1}
        {2, -1} -> {tx + 1, ty - 1}
        {-2, 1} -> {tx - 1, ty + 1}
        {-1, 2} -> {tx - 1, ty + 1}
        {-2, -1} -> {tx - 1, ty - 1}
        {-1, -2} -> {tx - 1, ty - 1}
        {2, 2} -> {tx + 1, ty + 1}
        {2, -2} -> {tx + 1, ty - 1}
        {-2, 2} -> {tx - 1, ty + 1}
        {-2, -2} -> {tx - 1, ty - 1}
        {_, _} -> {tx, ty}
      end

    {{hx, hy}, {tx, ty}}
  end
end

File.read!('lib/day9/input.txt') |> Day9.part1(2)
File.read!('lib/day9/input.txt') |> Day9.part1(10)
