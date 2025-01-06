import AOC

aoc 2024, 11 do
  require Integer

  @moduledoc """
  https://adventofcode.com/2024/day/11
  """

  @doc """
      iex> p1(example_string())
  """
  def p1(input) do
    String.split(input)
    |> Enum.map(&String.to_integer/1)
    |> Enum.group_by(& &1)
    |> Enum.map(fn {k, v} -> {k, Enum.count(v)} end)
    |> blink(25)
  end

  defp blink(stones, 0), do: Enum.sum_by(stones, &elem(&1, 1))

  defp blink(stones, blinks_left) do
    Enum.reduce(stones, %{}, fn stone, acc ->
      new_list = transform(stone)

      Enum.reduce(new_list, acc, fn {new_number, new_count}, acc ->
        Map.update(acc, new_number, new_count, &(&1 + new_count))
      end)
    end)
    |> blink(blinks_left - 1)
  end

  defp transform({0, count}) do
    [{1, count}]
  end

  defp transform({number, count}) do
    digits = Integer.digits(number)
    length = length(digits)

    cond do
      Integer.is_even(length) ->
        Enum.split(digits, div(length, 2))
        |> Tuple.to_list()
        |> Enum.map(&Integer.undigits/1)
        |> Enum.map(&{&1, count})

      true ->
        [{number * 2024, count}]
    end
  end

  @doc """
      iex> p2(example_string())
  """
  def p2(input) do
    String.split(input)
    |> Enum.map(&String.to_integer/1)
    |> Enum.group_by(& &1)
    |> Enum.map(fn {k, v} -> {k, Enum.count(v)} end)
    |> Task.async_stream(fn stone -> blink([stone], 75) end, timeout: :infinity)
    |> Enum.sum_by(fn {:ok, stones} -> stones end)
  end
end
