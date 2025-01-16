import AOC

aoc 2024, 12 do
  @moduledoc """
  https://adventofcode.com/2024/day/12
  """
  alias ElixirSense.Core.Struct

  @doc """
      iex> p1(example_string())
  """
  def p1(input) do
    grid = Grid.new(input)

    grid =
      Enum.reduce(grid.grid, grid, fn {pos, value}, acc ->
        Grid.set_value(acc, pos, {value, make_ref()})
      end)

    Enum.reduce(grid.grid, grid, fn {pos, {value, ref}}, acc ->
      area_ref = get_area_ref(grid, pos)
      Grid.set_value(acc, pos, {value, area_ref})
    end)

    # |> Map.get(:grid)
    # |> Enum.map(fn {{x, y} = pos, _value} ->
    #   fences = calc_fences(grid, {x, y})
    #   {pos, fences}
    # end)
  end

  defp calc_fences(grid, {x, y}) do
    value = Grid.get_value(grid, {x, y})

    fence_for_side(grid, {x - 1, y}, value) +
      fence_for_side(grid, {x + 1, y}, value) +
      fence_for_side(grid, {x, y - 1}, value) +
      fence_for_side(grid, {x, y + 1}, value)
  end

  defp fence_for_side(grid, {x, y}, value) do
    case Grid.get_value(grid, {x, y}) do
      ^value -> 0
      _ -> 1
    end
  end

  defp get_area_ref(grid, {x, y} = pos) do
    {value, ref} = Grid.get_value(grid, pos)
    {value_l, ref_l} = Grid.get_value(grid, {x - 1, y}, {nil, nil})
    {value_u, ref_u} = Grid.get_value(grid, {x, y - 1}, {nil, nil})

    cond do
      value_l == value -> ref_l
      value_u == value -> ref_u
      true -> ref
    end
  end

  @doc """
      iex> p2(example_string())
  """
  def p2(input) do
  end
end
