import AOC

aoc_test 2024, 9, async: true do
  test "p1" do
    assert p1(example_string()) == 1928
  end

  test "p2" do
    assert p2(example_string()) == 2858
  end
end
