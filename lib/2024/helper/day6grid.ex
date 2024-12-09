defmodule Day6Grid do
  defstruct([:grid, :pos, :direction, :width, :height])

  def new(input) do
    grid =
      String.split(input, "\n", trim: true)
      |> Enum.with_index(&{&1, &2})
      |> Enum.map(fn {str, row_num} ->
        {row_num, String.graphemes(str) |> Enum.with_index(&{&2, &1})}
      end)

    %Day6Grid{
      pos: get_initial_pos(grid),
      direction: {0, -1},
      grid: grid,
      height: length(grid),
      width: hd(grid) |> elem(1) |> length()
    }
  end

  def visit(%Day6Grid{pos: {x, y}, direction: {dx, dy}} = g) do
    update_in(
      g,
      [
        Access.key(:grid),
        Access.find(fn {row, _} -> row == y end),
        Access.elem(1),
        Access.find(fn {col, _} -> col == x end),
        Access.elem(1)
      ],
      fn
        "." -> "$#{dx},#{dy}"
        "^" -> "$#{dx},#{dy}"
        cell -> cell
      end
    )
  end

  def visited?(%Day6Grid{grid: grid, pos: {x, y}, direction: {dx, dy}}) do
    cell =
      get_in(grid, [
        Access.find(fn {row, _} -> row == y end),
        Access.elem(1),
        Access.find(fn {col, _} -> col == x end),
        Access.elem(1)
      ])

    cell == "$#{dx},#{dy}"
  end

  def block(%Day6Grid{} = grid, {x, y}) do
    update_in(
      grid,
      [
        Access.key(:grid),
        Access.find(fn {row, _} -> row == y end),
        Access.elem(1),
        Access.find(fn {col, _} -> col == x end),
        Access.elem(1)
      ],
      fn
        "." -> "#"
        cell -> cell
      end
    )
  end

  def walk(%Day6Grid{pos: {x, y}, direction: {dx, dy} = dir} = g) do
    cond do
      is_blocked?(g) -> %Day6Grid{g | direction: next_direction(dir)}
      true -> %Day6Grid{g | pos: {x + dx, y + dy}}
    end
  end

  defp is_blocked?(%Day6Grid{grid: grid, pos: {x, y}, direction: {dx, dy}}) do
    get_in(grid, [
      Access.find(fn {row, _} -> row == y + dy end),
      Access.elem(1),
      Access.find(fn {col, _} -> col == x + dx end),
      Access.elem(1)
    ]) == "#"
  end

  defp next_direction({0, -1}), do: {1, 0}
  defp next_direction({1, 0}), do: {0, 1}
  defp next_direction({0, 1}), do: {-1, 0}
  defp next_direction({-1, 0}), do: {0, -1}

  defp get_initial_pos(grid) do
    {y, row} =
      Enum.find(grid, fn {_row_num, row} ->
        Enum.find(row, fn {_col_num, char} ->
          if char == "^" do
            true
          end
        end)
      end)

    {x, _} =
      Enum.find(row, fn {_col_num, char} ->
        if char == "^" do
          true
        end
      end)

    {x, y}
  end
end
