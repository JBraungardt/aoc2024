import AOC

aoc_test 2024, 3, async: true do
  test "p1" do
    assert Y2024.D3.p1(example_string()) == 161
  end

  test "p2" do
    assert Y2024.D3.p2(example_string()) == 48
  end
end
