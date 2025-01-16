defmodule Grid do
  defstruct [:grid, :width, :height]

  def new(input, value_transformer \\ & &1) do
    lines = String.split(input, "\n", trim: true)

    grid =
      lines
      |> Stream.with_index(&{&1, &2})
      |> Enum.reduce(%{}, fn {str, row_num}, acc ->
        str
        |> String.graphemes()
        |> Stream.map(value_transformer)
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

  def get_value(grid, pos, default \\ nil)

  def get_value(%__MODULE__{height: height, width: width}, {x, y}, default)
      when x < 0 or x >= width or y < 0 or y >= height do
    default
  end

  def get_value(%__MODULE__{grid: grid}, {x, y}, _default) do
    Map.get(grid, {x, y})
  end

  def set_value(%__MODULE__{grid: grid} = m, {x, y}, new_value) do
    %__MODULE__{m | grid: Map.put(grid, {x, y}, new_value)}
  end
end
