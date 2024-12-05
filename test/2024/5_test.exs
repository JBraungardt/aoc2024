import AOC

aoc_test 2024, 5, async: true do
  test "p1" do
    assert Y2024.D5.p1(example_string()) == 143
  end
end
