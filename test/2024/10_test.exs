import AOC

aoc_test 2024, 10, async: true do
  test "p1" do
    assert p1(example_string()) == 36
  end

  test "p2" do
    assert p2(example_string()) == 81
  end
end
