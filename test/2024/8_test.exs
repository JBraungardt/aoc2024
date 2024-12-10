import AOC

aoc_test 2024, 8, async: true do
  test "p1" do
    assert Y2024.D8.p1(example_string()) == 14
  end
end
