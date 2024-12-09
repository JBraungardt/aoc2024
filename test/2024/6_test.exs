import AOC

aoc_test 2024, 6, async: true do
  test "p1" do
    assert Y2024.D6.p1(example_string()) == 41
  end

  test "p2" do
    assert Y2024.D6.p2(example_string()) == 6
  end
end
