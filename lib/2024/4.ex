import AOC

aoc 2024, 4 do
  @moduledoc """
  https://adventofcode.com/2024/day/4
  """

  @doc """
      iex> p1(example_string())
  """
  def p1(input) do
    grid =
      String.split(input, "\n", trim: true)
      |> Enum.with_index(&{&1, &2})
      |> Enum.map(fn {str, row_num} ->
        {row_num, String.graphemes(str) |> Enum.with_index(&{&2, &1})}
      end)

    rows = length(grid)
    cols = hd(grid) |> elem(1) |> length()

    grid =
      Enum.reduce(grid, %{}, fn {row_num, row}, acc ->
        Enum.reduce(row, acc, fn {col_num, char}, acc ->
          Map.put(acc, {row_num, col_num}, char)
        end)
      end)

    Enum.reduce(grid, 0, fn entry, acc ->
      count_xmas(entry, grid, rows, cols) + acc
    end)
  end

  # {{row_num, col_num}, char}

  defp count_xmas({pos, "X"}, grid, rows, cols) do
    check_left(pos, grid, rows, cols) + check_right(pos, grid, rows, cols) +
      check_up(pos, grid, rows, cols) + check_down(pos, grid, rows, cols) +
      check_up_left(pos, grid, rows, cols) + check_up_right(pos, grid, rows, cols) +
      check_down_left(pos, grid, rows, cols) + check_down_right(pos, grid, rows, cols)
  end

  defp count_xmas(_, _, _, _) do
    0
  end

  defp check_left({row, col}, grid, rows, cols) do
    if is_char_at_pos("M", {row, col - 1}, grid, rows, cols) &&
         is_char_at_pos("A", {row, col - 2}, grid, rows, cols) &&
         is_char_at_pos("S", {row, col - 3}, grid, rows, cols) do
      1
    else
      0
    end
  end

  defp check_right({row, col}, grid, rows, cols) do
    if is_char_at_pos("M", {row, col + 1}, grid, rows, cols) &&
         is_char_at_pos("A", {row, col + 2}, grid, rows, cols) &&
         is_char_at_pos("S", {row, col + 3}, grid, rows, cols) do
      1
    else
      0
    end
  end

  defp check_up({row, col}, grid, rows, cols) do
    if is_char_at_pos("M", {row - 1, col}, grid, rows, cols) &&
         is_char_at_pos("A", {row - 2, col}, grid, rows, cols) &&
         is_char_at_pos("S", {row - 3, col}, grid, rows, cols) do
      1
    else
      0
    end
  end

  defp check_down({row, col}, grid, rows, cols) do
    if is_char_at_pos("M", {row + 1, col}, grid, rows, cols) &&
         is_char_at_pos("A", {row + 2, col}, grid, rows, cols) &&
         is_char_at_pos("S", {row + 3, col}, grid, rows, cols) do
      1
    else
      0
    end
  end

  defp check_up_left({row, col}, grid, rows, cols) do
    if is_char_at_pos("M", {row - 1, col - 1}, grid, rows, cols) &&
         is_char_at_pos("A", {row - 2, col - 2}, grid, rows, cols) &&
         is_char_at_pos("S", {row - 3, col - 3}, grid, rows, cols) do
      1
    else
      0
    end
  end

  defp check_up_right({row, col}, grid, rows, cols) do
    if is_char_at_pos("M", {row - 1, col + 1}, grid, rows, cols) &&
         is_char_at_pos("A", {row - 2, col + 2}, grid, rows, cols) &&
         is_char_at_pos("S", {row - 3, col + 3}, grid, rows, cols) do
      1
    else
      0
    end
  end

  defp check_down_left({row, col}, grid, rows, cols) do
    if is_char_at_pos("M", {row + 1, col - 1}, grid, rows, cols) &&
         is_char_at_pos("A", {row + 2, col - 2}, grid, rows, cols) &&
         is_char_at_pos("S", {row + 3, col - 3}, grid, rows, cols) do
      1
    else
      0
    end
  end

  defp check_down_right({row, col}, grid, rows, cols) do
    if is_char_at_pos("M", {row + 1, col + 1}, grid, rows, cols) &&
         is_char_at_pos("A", {row + 2, col + 2}, grid, rows, cols) &&
         is_char_at_pos("S", {row + 3, col + 3}, grid, rows, cols) do
      1
    else
      0
    end
  end

  defp is_char_at_pos(char, {row, col}, grid, rows, cols) do
    cond do
      row > rows -> false
      col > cols -> false
      row < 0 -> false
      col < 0 -> false
      grid[{row, col}] == char -> true
      true -> false
    end
  end

  @doc """
      iex> p2(example_string())
  """
  def p2(input) do
    grid =
      String.split(input, "\n", trim: true)
      |> Enum.with_index(&{&1, &2})
      |> Enum.map(fn {str, row_num} ->
        {row_num, String.graphemes(str) |> Enum.with_index(&{&2, &1})}
      end)

    rows = length(grid)
    cols = hd(grid) |> elem(1) |> length()

    grid =
      Enum.reduce(grid, %{}, fn {row_num, row}, acc ->
        Enum.reduce(row, acc, fn {col_num, char}, acc ->
          Map.put(acc, {row_num, col_num}, char)
        end)
      end)

    Enum.reduce(grid, 0, fn entry, acc ->
      count_xmas2(entry, grid, rows, cols) + acc
    end)
  end

  defp count_xmas2({{row, col}, "A"}, grid, rows, cols) do
    if ((is_char_at_pos("M", {row - 1, col - 1}, grid, rows, cols) and
           is_char_at_pos("S", {row + 1, col + 1}, grid, rows, cols)) or
          (is_char_at_pos("S", {row - 1, col - 1}, grid, rows, cols) and
             is_char_at_pos("M", {row + 1, col + 1}, grid, rows, cols))) and
         ((is_char_at_pos("M", {row - 1, col + 1}, grid, rows, cols) and
             is_char_at_pos("S", {row + 1, col - 1}, grid, rows, cols)) or
            (is_char_at_pos("S", {row - 1, col + 1}, grid, rows, cols) and
               is_char_at_pos("M", {row + 1, col - 1}, grid, rows, cols))) do
      1
    else
      0
    end
  end

  defp count_xmas2(_, _, _, _) do
    0
  end
end
