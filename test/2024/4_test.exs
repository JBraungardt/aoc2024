import AOC

aoc_test 2024, 4, async: true do
  test "p1" do
    assert Y2024.D4.p1(example_string()) == 18
  end

  test "p1" do
    assert Y2024.D4.p2(example_string()) == 9
  end
end
