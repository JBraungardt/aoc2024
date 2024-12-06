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
