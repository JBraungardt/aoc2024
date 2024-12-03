import AOC

aoc 2024, 3 do
  @moduledoc """
  https://adventofcode.com/2024/day/3
  """

  @doc """
      iex> p1(example_string())
  """
  def p1(input) do
    Regex.scan(~r/mul\((\d{1,3}),(\d{1,3})\)/U, input)
    |> Enum.map(fn [_, a, b] -> String.to_integer(a) * String.to_integer(b) end)
    |> Enum.sum()
  end

  @doc """
      iex> p2(example_string())
  """
  def p2(input) do
    Regex.scan(~r/mul\((\d{1,3}),(\d{1,3})\)|do\(\)|don\'t\(\)/, input)
    |> Enum.reduce({0, :on}, fn x, {acc, mode} ->
      case {x, mode} do
        {["do()"], _} -> {acc, :on}
        {["don't()"], _} -> {acc, :off}
        {[_, a, b], :on} -> {acc + String.to_integer(a) * String.to_integer(b), :on}
        {_, :off} -> {acc, :off}
      end
    end)
    |> elem(0)
  end
end
