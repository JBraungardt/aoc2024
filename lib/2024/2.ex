import AOC

aoc 2024, 2 do
  @moduledoc """
  https://adventofcode.com/2024/day/2
  """

  @doc """
      iex> p1(example_string())
  """
  def p1(input) do
    reports = get_reports(input)

    Enum.map(reports, &is_valid1?/1)
    |> Enum.count(& &1)
  end

  @doc """
      iex> p2(example_string())
  """
  def p2(input) do
    reports = get_reports(input)

    Enum.map(reports, &is_valid2?/1)
    |> Enum.count(& &1)
  end

  defp get_reports(input) do
    input
    |> String.split("\n", trim: true)
    |> Enum.map(fn r ->
      String.split(r, " ", trim: true)
      |> Enum.map(&String.to_integer/1)
    end)
  end

  defp is_valid1?(report) do
    diffs =
      Enum.chunk_every(report, 2, 1, :discard)
      |> Enum.map(fn [x, y] ->
        x - y
      end)

    cond do
      Enum.all?(diffs, &(&1 > 0 && &1 <= 3)) -> true
      Enum.all?(diffs, &(&1 < 0 && &1 >= -3)) -> true
      true -> false
    end
  end

  defp is_valid2?(report) do
    diffs =
      Enum.chunk_every(report, 2, 1, :discard)
      |> Enum.map(fn [x, y] ->
        x - y
      end)

    cond do
      Enum.all?(diffs, &(&1 > 0 && &1 <= 3)) -> true
      Enum.all?(diffs, &(&1 < 0 && &1 >= -3)) -> true
      true -> sub_list_valid?(report)
    end
  end

  defp sub_list_valid?(report) do
    0..(Enum.count(report) - 1)
    |> Enum.map(fn i -> List.delete_at(report, i) end)
    |> Enum.map(&is_valid1?/1)
    |> Enum.any?(& &1)
  end
end
