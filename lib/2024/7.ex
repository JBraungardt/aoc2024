import AOC

aoc 2024, 7 do
  @moduledoc """
  https://adventofcode.com/2024/day/7
  """

  @doc """
      iex> p1(example_string())
  """
  def p1(input) do
    parse_input(input)
    |> Enum.filter(fn entry -> is_valid(entry, [&Kernel.+/2, &Kernel.*/2]) end)
    |> Enum.reduce(0, fn [result, _values], acc ->
      acc + result
    end)
  end

  defp is_valid([result, values], operators) do
    gen_operators(length(values) - 2, operators, operators)
    |> Enum.any?(fn ops ->
      calc(Enum.drop(values, 1), ops, hd(values)) ==
        result
    end)
  end

  defp calc([], [], acc), do: acc

  defp calc([a | rest_values], [op | rest_ops], acc) do
    calc(rest_values, rest_ops, op.(acc, a))
  end

  defp gen_operators(0, _ops, acc), do: Enum.map(acc, &List.flatten([&1]))

  defp gen_operators(n, ops, acc) do
    comb =
      Enum.reduce(acc, [], fn e, acc ->
        for op <- ops do
          [op | List.flatten([e])]
        end ++ acc
      end)

    gen_operators(n - 1, ops, comb)
  end

  @doc """
      iex> p2(example_string())
  """
  def p2(input) do
    parse_input(input)
    |> Enum.filter(fn entry -> is_valid(entry, [&Kernel.+/2, &Kernel.*/2, &concat/2]) end)
    |> Enum.reduce(0, fn [result, _values], acc ->
      acc + result
    end)
  end

  defp concat(a, b) do
    String.to_integer("#{a}#{b}")
  end

  defp parse_input(input) do
    input
    |> String.split("\n", trim: true)
    |> Enum.map(&parse_line/1)
  end

  defp parse_line(line) do
    [result, values] = String.split(line, ": ", trim: true)

    [
      String.to_integer(result),
      String.split(values, " ", trim: true) |> Enum.map(&String.to_integer/1)
    ]
  end
end
