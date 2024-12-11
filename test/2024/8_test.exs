import AOC

aoc_test 2024, 8, async: true do
  test "p1" do
    assert p1(example_string()) == 14
  end

  test "p2" do
    assert p2(example_string()) == 34
  end
end
