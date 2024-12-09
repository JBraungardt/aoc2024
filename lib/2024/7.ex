import AOC

aoc 2024, 7 do
  @moduledoc """
  https://adventofcode.com/2024/day/7
  """

  @doc """
      iex> p1(example_string())
  """
  def p1(_input) do
    _operators =
      gen_operators(11, ["a", "b", "c"], ["a", "b", "c"])
      |> length()
  end

  defp gen_operators(0, _ops, acc), do: acc

  defp gen_operators(n, ops, acc) do
    comb =
      Enum.reduce(acc, [], fn e, acc ->
        for op <- ops do
          [op | [e]] |> List.flatten()
        end ++ acc
      end)

    gen_operators(n - 1, ops, comb)
  end

  @doc """
      iex> p2(example_string())
  """
  def p2(_input) do
  end
end
