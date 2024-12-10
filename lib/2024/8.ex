import AOC

aoc 2024, 8 do
  @moduledoc """
  https://adventofcode.com/2024/day/8
  """

  @doc """
      iex> p1(example_string())
  """
  def p1(input) do
    {rows, cols, grid} = parse_input(input)

    grid
    |> Enum.filter(fn {_, _, char} -> char != "." end)
    |> Enum.group_by(fn {_, _, char} -> char end, fn {row, col, _} -> {row, col} end)
    |> Enum.map(fn {_, nodes} ->
      antinodes(nodes, [])
      |> Enum.filter(fn {x, y} -> x >= 0 && y >= 0 && x < rows && y < cols end)
    end)
    |> List.flatten()
    |> Enum.uniq()
    |> Enum.count()
  end

  defp antinodes([_last], antinodes), do: antinodes

  defp antinodes([{hx, hy} | t], antinodes) do
    antinodes =
      Enum.reduce(t, antinodes, fn {nx, ny}, acc ->
        {dx, dy} = {
          (nx - hx) |> abs(),
          (ny - hy) |> abs()
        }

        acc
        |> List.insert_at(
          0,
          {cond do
             nx >= hx -> nx + dx
             nx < hx -> nx - dx
           end,
           cond do
             ny >= hy -> ny + dy
             ny < hy -> ny - dy
           end}
        )
        |> List.insert_at(
          0,
          {cond do
             hx >= nx -> hx + dx
             hx < nx -> hx - dx
           end,
           cond do
             hy >= ny -> hy + dy
             hy < ny -> hy - dy
           end}
        )
      end)

    antinodes(t, antinodes)
  end

  @doc """
      iex> p2(example_string())
  """
  def p2(_input) do
  end

  defp parse_input(input) do
    lines = String.split(input, "\n", trim: true)

    grid =
      lines
      |> Enum.with_index(&{&1, &2})
      |> Enum.reduce([], fn {str, row_num}, acc ->
        str
        |> String.graphemes()
        |> Enum.with_index(&{&1, &2})
        |> Enum.reduce(acc, fn {char, col_num}, acc ->
          List.insert_at(acc, 0, {row_num, col_num, char})
        end)
      end)

    {length(lines), Enum.at(lines, 0) |> String.length(), grid}
  end
end
