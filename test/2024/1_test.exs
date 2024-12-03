import AOC

aoc_test 2024, 1, async: true do
  test "p1" do
    assert Y2024.D1.p1(example_string()) == 11
  end

  test "p2" do
    assert Y2024.D1.p2(example_string()) == 31
  end
end
