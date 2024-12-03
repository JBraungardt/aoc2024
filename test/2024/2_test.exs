import AOC

aoc_test 2024, 2, async: true do
  test "p1" do
    assert Y2024.D2.p1(example_string()) == 2
  end

  test "p2" do
    assert Y2024.D2.p2(example_string()) == 4
  end
end
