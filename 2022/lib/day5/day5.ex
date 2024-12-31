defmodule AOC22.Day5 do
  def part1(input) do
    input
    |> String.split("\n")
    |> Enum.drop(10)
    |> Enum.map(fn cmd ->
      Regex.run(~r/move (.+?) from (.+?) to (.+?)/, cmd, capture: :all_but_first)
      |> List.to_tuple()
    end)
    |> Enum.reduce(
      # left: top of the stack, right: bottom of the stack
      %{
        "1" => [P, G, R, N],
        "2" => [C, D, G, F, L, B, T, J],
        "3" => [V, S, M],
        "4" => [P, Z, C, R, S, L],
        "5" => [Q, D, W, C, V, L, S, P],
        "6" => [S, M, D, W, N, T, C],
        "7" => [P, W, G, D, H],
        "8" => [V, M, C, S, H, P, L, Z],
        "9" => [Z, G, W, L, F, P, R]
      },
      fn {move_by, from, to}, stacks ->
        move_crate_mover_9000(stacks, String.to_integer(move_by), from, to)
      end
    )
    |> IO.inspect()
    |> Enum.map(fn {_, [v | _]} -> v end)
    |> IO.inspect()
  end

  defp move_crate_mover_9000(st, move, from, to) do
    new_from = Map.get(st, from) |> Enum.drop(move)
    popped = Map.get(st, from) |> Enum.take(move) |> Enum.reverse()
    new_to = Enum.concat(popped, Map.get(st, to))
    st |> Map.put(from, new_from) |> Map.put(to, new_to)
  end

  def part2(input) do
    input
    |> String.split("\n")
    |> Enum.drop(10)
    |> Enum.map(fn cmd ->
      Regex.run(~r/move (.+?) from (.+?) to (.+?)/, cmd, capture: :all_but_first)
      |> List.to_tuple()
    end)
    |> Enum.reduce(
      # left: top of the stack, right: bottom of the stack
      %{
        "1" => [P, G, R, N],
        "2" => [C, D, G, F, L, B, T, J],
        "3" => [V, S, M],
        "4" => [P, Z, C, R, S, L],
        "5" => [Q, D, W, C, V, L, S, P],
        "6" => [S, M, D, W, N, T, C],
        "7" => [P, W, G, D, H],
        "8" => [V, M, C, S, H, P, L, Z],
        "9" => [Z, G, W, L, F, P, R]
      },
      fn {move_by, from, to}, stacks ->
        move_crate_mover_9001(stacks, String.to_integer(move_by), from, to)
      end
    )
    |> IO.inspect()
    |> Enum.map(fn {_, [v | _]} -> v end)
    |> IO.inspect()
  end

  defp move_crate_mover_9001(st, move, from, to) do
    new_from = Map.get(st, from) |> Enum.drop(move)
    popped = Map.get(st, from) |> Enum.take(move)
    new_to = Enum.concat(popped, Map.get(st, to))
    st |> Map.put(from, new_from) |> Map.put(to, new_to)
  end
end

File.read!('lib/day5/input.txt') |> AOC22.Day5.part1()
File.read!('lib/day5/input.txt') |> AOC22.Day5.part2()
