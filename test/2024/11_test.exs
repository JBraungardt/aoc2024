import AOC

aoc_test 2024, 11, async: true do
  test "p1" do
    assert p1(example_string()) == 55312
  end

  test "p2" do
    assert p2(example_string()) == 65_601_038_650_482
  end
end
