import AOC

aoc 2024, 1 do
  @moduledoc """
  https://adventofcode.com/2024/day/1
  """

  @doc """
      iex> p1(example_string())
  """
  def p1(input) do
    [l1, l2] = lists_from_input(input)

    Enum.zip(l1, l2)
    |> Enum.map(fn {a, b} -> a - b end)
    |> Enum.map(&abs/1)
    |> Enum.sum()
  end

  @doc """
      iex> p2(example_string())
  """
  def p2(input) do
    [l1, l2] = lists_from_input(input)

    Enum.reduce(l1, 0, fn x, acc ->
      count = Enum.count(l2, fn y -> y == x end)
      acc + count * x
    end)
  end

  defp lists_from_input(input) do
    input
    |> String.split("\n", trim: true)
    |> Enum.reduce([[], []], fn line, acc ->
      [part1, part2] =
        String.split(line, " ", trim: true)
        |> Enum.map(&String.to_integer/1)

      [[part1] ++ List.first(acc, 0), [part2] ++ List.last(acc, 1)]
    end)
    |> Enum.map(&Enum.sort/1)
  end
end
