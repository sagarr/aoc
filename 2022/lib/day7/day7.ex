defmodule Day7 do
  def part1(input) do
    input
    |> String.split("\n")
    |> Enum.reduce({%{}, []}, fn cmd, {dir_size_map, dirs} -> parse(cmd, dir_size_map, dirs) end)
    |> elem(0)
    |> Enum.map(fn {_dir, size} -> size end)
    |> Enum.filter(&(&1 <= 100_000))
    |> Enum.sum()
    |> IO.inspect()
  end

  defp parse("$ cd /", dir_size_map, _dirs) do
    {dir_size_map, ["ROOT"]}
  end

  defp parse("$ cd ..", dir_size_map, dirs) do
    {dir_size_map, tl(dirs)}
  end

  defp parse("$ cd " <> dir_name, dir_size_map, dirs) do
    {dir_size_map, [dir_name | dirs]}
  end

  defp parse("$ ls", dir_size_map, dirs) do
    {dir_size_map, dirs}
  end

  defp parse("dir " <> _dir_name, dir_size_map, dirs) do
    {dir_size_map, dirs}
  end

  defp parse(file, dir_size_map, dirs) do
    [size, _file_name] = String.split(file)
    {calc_size(dirs, String.to_integer(size), dir_size_map), dirs}
  end

  defp calc_size([], _size, dir_size_map), do: dir_size_map

  defp calc_size(dirs, size, dir_size_map) do
    calc_size(tl(dirs), size, Map.update(dir_size_map, Enum.join(dirs, "/"), size, &(&1 + size)))
  end

  def part2(input) do
    dir_size_map =
      input
      |> String.split("\n")
      |> Enum.reduce({%{}, []}, fn cmd, {dir_size_map, dirs} -> parse(cmd, dir_size_map, dirs) end)
      |> elem(0)

    free_space = 70_000_000 - dir_size_map["ROOT"]
    need_to_delete = 30_000_000 - free_space

    dir_size_map
    |> Enum.filter(fn {_dir, size} -> size >= need_to_delete end)
    |> Enum.min_by(fn {_dir, size} -> size end)
    |> IO.inspect()
  end
end

# File.read!('lib/day7/input.txt') |> Day7.part1()
File.read!('lib/day7/input.txt') |> Day7.part2()
