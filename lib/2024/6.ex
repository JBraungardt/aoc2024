import AOC

aoc 2024, 6 do
  @moduledoc """
  https://adventofcode.com/2024/day/6
  """

  @doc """
      iex> p1(example_string())
  """
  def p1(input) do
    Day6Grid.new(input)
    |> walk()
    |> get_in([Access.key(:grid)])
    |> Enum.reduce(0, fn {_, row}, acc ->
      Enum.count(row, &String.starts_with?(elem(&1, 1), "$")) + acc
    end)
  end

  defp walk(%Day6Grid{height: h, pos: {_, y}} = grid) when y > h, do: grid
  defp walk(%Day6Grid{pos: {_, y}} = grid) when y < 0, do: grid
  defp walk(%Day6Grid{width: w, pos: {x, _}} = grid) when x > w, do: grid
  defp walk(%Day6Grid{pos: {x, _}} = grid) when x < 0, do: grid

  defp walk(%Day6Grid{} = g) do
    case Day6Grid.visited?(g) do
      true ->
        true

      false ->
        Day6Grid.visit(g)
        |> Day6Grid.walk()
        |> walk()
    end
  end

  @doc """
      iex> p2(example_string())
  """
  def p2(input) do
    g = Day6Grid.new(input)

    for y <- 0..(g.height - 1),
        x <- 0..(g.width - 1),
        reduce: 0 do
      acc ->
        case Day6Grid.block(g, {x, y}) |> walk() do
          true -> acc + 1
          _ -> acc
        end
    end
  end
end
