import AOC

aoc 2024, 5 do
  @moduledoc """
  https://adventofcode.com/2024/day/5
  """

  @doc """
      iex> p1(example_string())
  """
  def p1(input) do
    {rules, updates} = parse_input(input)

    Enum.filter(updates, &is_valid?(&1, rules))
    |> Enum.map(&middle_element/1)
    |> Enum.sum()
  end

  defp is_valid?(update, rules)
       when is_list(update) and is_list(rules) do
    Enum.with_index(update)
    |> Enum.map(&is_element_valid?(&1, update, rules))
    |> Enum.all?()
  end

  defp is_element_valid?({element, index}, update, rules) do
    current_rules = Enum.filter(rules, &Enum.member?(&1, element))

    {before, past} = Enum.split(update, index)
    past = Enum.drop(past, 1)

    Enum.reduce(current_rules, true, fn rule, acc ->
      case rule do
        [^element, to_check] -> not Enum.member?(before, to_check) and acc
        [to_check, ^element] -> not Enum.member?(past, to_check) and acc
      end
    end)
  end

  defp middle_element(update) when is_list(update) do
    Enum.at(update, div(length(update), 2))
  end

  @doc """
      iex> p2(example_string())
  """
  def p2(input) do
    {rules, updates} = parse_input(input)

    Enum.filter(updates, &(!is_valid?(&1, rules)))
    |> Enum.map(&fix_update(&1, rules))
    |> Enum.map(&middle_element/1)
    |> Enum.sum()
  end

  defp fix_update(update, rules) do
    Enum.sort(update, fn a, b -> Enum.member?(rules, [a, b]) end)
  end

  defp parse_input(input) do
    [rules, updates] = String.split(input, "\n\n", trim: true)

    rules =
      String.split(rules, "\n", trim: true)
      |> Enum.map(fn line ->
        String.split(line, "|", trim: true) |> Enum.map(&String.to_integer/1)
      end)

    updates =
      String.split(updates, "\n", trim: true)
      |> Enum.map(fn line ->
        String.split(line, ",", trim: true) |> Enum.map(&String.to_integer/1)
      end)

    {rules, updates}
  end
end
