defmodule AOC22.Day6 do
  def solution(input, chunk_size) do
    input
    |> String.split("", trim: true)
    |> Enum.chunk_every(chunk_size, 1, :discard)
    |> Enum.map(fn chunk -> Enum.map(chunk, fn x -> {x, x} end) end)
    |> Enum.reduce_while(0, fn chunk, count ->
      if map_size(Map.new(chunk)) == chunk_size do
        {:halt, count + chunk_size}
      else
        {:cont, count + 1}
      end
    end)
    |> IO.inspect()
  end
end

File.read!('lib/day6/input.txt') |> AOC22.Day6.solution(14)
File.read!('lib/day6/input.txt') |> AOC22.Day6.solution(4)
