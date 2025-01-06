defmodule Day10grid do
  defstruct [:grid, :width, :height]

  def new(input) do
    lines = String.split(input, "\n", trim: true)

    grid =
      lines
      |> Stream.with_index(&{&1, &2})
      |> Enum.reduce(%{}, fn {str, row_num}, acc ->
        str
        |> String.graphemes()
        |> Stream.map(&String.to_integer/1)
        |> Stream.with_index(&{&1, &2})
        |> Enum.reduce(acc, fn {val, col_num}, acc ->
          Map.put(acc, {col_num, row_num}, val)
        end)
      end)

    %__MODULE__{
      grid: grid,
      height: length(lines),
      width: Enum.at(lines, 0) |> String.length()
    }
  end

  def get_value(%__MODULE__{grid: grid}, {x, y}) do
    Map.get(grid, {x, y})
  end
end
