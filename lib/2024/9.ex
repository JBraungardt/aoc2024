import AOC

aoc 2024, 9 do
  @moduledoc """
  https://adventofcode.com/2024/day/9
  """
  require Integer

  @doc """
      iex> p1(example_string())
  """
  def p1(input) do
    generate_file_system(input)
    |> compact()
    |> calc_checksum()
  end

  @doc """
      iex> p2(example_string())
  """
  def p2(input) do
    file_id = div(String.length(input), 2)

    generate_file_system(input)
    |> compact2(file_id)
    |> calc_checksum()
  end

  def generate_file_system(input) do
    input
    |> String.graphemes()
    |> Enum.map(&String.to_integer/1)
    |> Enum.with_index()
    |> Enum.reduce([], fn {size, index}, acc ->
      acc ++ gen_block(size, index)
    end)
  end

  defp gen_block(0, _) do
    []
  end

  defp gen_block(size, index) when Integer.is_even(index) do
    Enum.map(1..size, fn _ -> div(index, 2) end)
  end

  defp gen_block(size, index) when Integer.is_odd(index) do
    List.duplicate(nil, size)
  end

  defp compact(file_system) do
    move_block(file_system, length(file_system) - 1)
  end

  defp move_block(file_system, block_pos)
       when block_pos < length(file_system) / 2 do
    file_system
  end

  defp move_block(file_system, block_pos) do
    file_id = Enum.at(file_system, block_pos)
    first_free_index = Enum.find_index(file_system, &(&1 == nil))

    if first_free_index > block_pos do
      file_system
    else
      case file_id do
        nil ->
          move_block(file_system, block_pos - 1)

        _ ->
          file_system
          |> List.replace_at(block_pos, nil)
          |> List.replace_at(first_free_index, file_id)
          |> move_block(block_pos - 1)
      end
    end
  end

  defp calc_checksum(file_system) do
    Enum.with_index(file_system)
    |> Enum.reduce(0, fn {file_id, index}, acc ->
      checksum_for_pos(file_id, index) + acc
    end)
  end

  defp checksum_for_pos(nil, _), do: 0
  defp checksum_for_pos(file_id, index), do: file_id * index

  defp compact2(file_system, file_id) do
    move_file(file_system, file_id)
  end

  defp move_file(file_system, 0), do: List.flatten(file_system)

  defp move_file(file_system, file_id) do
    blocks =
      file_system
      |> Enum.chunk_by(& &1)

    file_block_index = Enum.find_index(blocks, &(List.first(&1) == file_id))
    file_block = Enum.at(blocks, file_block_index)
    file_block_size = length(file_block)

    free_block_index =
      Enum.find_index(blocks, &(List.first(&1) == nil && length(&1) >= file_block_size))

    if free_block_index == nil or free_block_index > file_block_index do
      move_file(file_system, file_id - 1)
    else
      free_block_size = Enum.at(blocks, free_block_index) |> length()

      blocks
      |> List.replace_at(file_block_index, List.duplicate(nil, file_block_size))
      |> List.replace_at(
        free_block_index,
        file_block ++ List.duplicate(nil, free_block_size - file_block_size)
      )
      |> List.flatten()
      |> move_file(file_id - 1)
    end
  end
end
