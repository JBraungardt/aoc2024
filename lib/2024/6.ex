import AOC

aoc 2024, 6 do
  @moduledoc """
  https://adventofcode.com/2024/day/6
  """

  @doc """
      iex> p1(example_string())
  """
  def p1(input) do
    grid =
      Day6Grid.new(input)
      |> walk()
  end

  defp walk(%Day6Grid{height: h, pos: {_, y}} = grid) when y > h, do: grid
  defp walk(%Day6Grid{pos: {_, y}} = grid) when y < 0, do: grid
  defp walk(%Day6Grid{width: w, pos: {x, _}} = grid) when x > w, do: grid
  defp walk(%Day6Grid{pos: {x, _}} = grid) when x < 0, do: grid

  defp walk(%Day6Grid{grid: grid, pos: {x, y}, direction: {dx, dy}} = s) do
    walk(%{s | pos: {x + dx, y + dy}})
  end

  @doc """
      iex> p2(example_string())
  """
  def p2(input) do
  end
end
