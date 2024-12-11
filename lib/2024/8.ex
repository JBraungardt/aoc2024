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
      antinodes(nodes, [], cols, rows)
      |> Enum.filter(fn {x, y} -> x >= 0 && y >= 0 && x < rows && y < cols end)
    end)
    |> List.flatten()
    |> Enum.uniq()
    |> Enum.count()
  end

  defp antinodes([_last], antinodes, _width, _height), do: antinodes

  defp antinodes([{hx, hy} | t], antinodes, width, height) do
    antinodes =
      Enum.reduce(t, antinodes, fn {nx, ny}, acc ->
        acc
        |> add_node({nx, ny}, {nx - hx, ny - hy}, width, height)
        |> add_node({hx, hy}, {hx - nx, hy - ny}, width, height)
      end)

    antinodes(t, antinodes, width, height)
  end

  defp add_node(nodes, {nx, ny}, {dx, dy}, width, height)
       when nx + dx < 0 or nx + dx > width or ny + dy < 0 or ny + dy > height,
       do: nodes

  defp add_node(nodes, {nx, ny}, {dx, dy}, _width, _height) do
    List.insert_at(nodes, 0, {nx + dx, ny + dy})
  end

  @doc """
      iex> p2(example_string())
  """
  def p2(input) do
    {rows, cols, grid} = parse_input(input)

    grid
    |> Enum.filter(fn {_, _, char} -> char != "." end)
    |> Enum.group_by(fn {_, _, char} -> char end, fn {row, col, _} -> {row, col} end)
    |> Enum.map(fn {_, nodes} ->
      antinodes2(nodes, [], cols, rows)
      |> Enum.filter(fn {x, y} -> x >= 0 && y >= 0 && x < rows && y < cols end)
    end)
    |> List.flatten()
    |> Enum.uniq()
    |> Enum.count()
  end

  defp antinodes2([_last], antinodes, _width, _height), do: antinodes

  defp antinodes2([{hx, hy} | t], antinodes, width, height) do
    antinodes =
      Enum.reduce(t, antinodes, fn {nx, ny}, acc ->
        acc
        |> List.insert_at(0, {nx, ny})
        |> List.insert_at(0, {hx, hy})
        |> add_node2({nx, ny}, {nx - hx, ny - hy}, width, height)
        |> add_node2({hx, hy}, {hx - nx, hy - ny}, width, height)
      end)

    antinodes2(t, antinodes, width, height)
  end

  defp add_node2(nodes, {nx, ny}, {dx, dy}, width, height)
       when nx + dx < 0 or nx + dx > width or ny + dy < 0 or ny + dy > height,
       do: nodes

  defp add_node2(nodes, {nx, ny}, {dx, dy}, width, height) do
    new_node = {nx + dx, ny + dy}

    List.insert_at(nodes, 0, new_node)
    |> add_node2(new_node, {dx, dy}, width, height)
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
