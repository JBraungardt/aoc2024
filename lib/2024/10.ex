import AOC

aoc 2024, 10 do
  @moduledoc """
  https://adventofcode.com/2024/day/10
  """

  @doc """
      iex> p1(example_string())
  """
  def p1(input) do
    grid = Day10grid.new(input)

    for y <- 0..(grid.width - 1), x <- 0..(grid.height - 1) do
      trailhead(grid, {x, y}, 0, MapSet.new())
    end
    |> Enum.map(&MapSet.size(&1))
    |> Enum.sum()
  end

  defp trailhead(grid, {x, y}, _value, trailheads)
       when x < 0 or x >= grid.width or y < 0 or y >= grid.height do
    trailheads
  end

  defp trailhead(grid, {x, y}, 9, trailheads) do
    case Day10grid.get_value(grid, {x, y}) do
      9 ->
        MapSet.put(trailheads, {x, y})

      _ ->
        trailheads
    end
  end

  defp trailhead(grid, {x, y}, value, trailheads) do
    if Day10grid.get_value(grid, {x, y}) == value do
      trailheads = trailhead(grid, {x + 1, y}, value + 1, trailheads)
      trailheads = trailhead(grid, {x, y + 1}, value + 1, trailheads)
      trailheads = trailhead(grid, {x - 1, y}, value + 1, trailheads)
      trailheads = trailhead(grid, {x, y - 1}, value + 1, trailheads)

      trailheads
    else
      trailheads
    end
  end

  defp check_path(grid, {x, y}, _value, _routes)
       when x < 0 or x >= grid.width or y < 0 or y >= grid.height do
    0
  end

  defp check_path(grid, {x, y}, 9, _routes) do
    case Day10grid.get_value(grid, {x, y}) do
      9 -> 1
      _ -> 0
    end
  end

  defp check_path(grid, {x, y}, value, routes) do
    if Day10grid.get_value(grid, {x, y}) == value do
      routes +
        check_path(grid, {x + 1, y}, value + 1, routes) +
        check_path(grid, {x, y + 1}, value + 1, routes) +
        check_path(grid, {x - 1, y}, value + 1, routes) +
        check_path(grid, {x, y - 1}, value + 1, routes)
    else
      0
    end
  end

  @doc """
      iex> p2(example_string())
  """
  def p2(input) do
    grid = Day10grid.new(input)

    for y <- 0..(grid.width - 1), x <- 0..(grid.height - 1) do
      check_path(grid, {x, y}, 0, 0)
    end
    |> Enum.sum()
  end
end
