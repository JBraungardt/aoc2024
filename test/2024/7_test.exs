import AOC

aoc_test 2024, 7, async: true do
  test "p1" do
    assert Y2024.D7.p1(example_string()) == 3749
  end
end
