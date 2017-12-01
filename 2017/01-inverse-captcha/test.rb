require 'minitest'
require 'minitest/autorun'
require 'minitest/pride'

require_relative 'solution/part_one'
require_relative 'solution/part_two'

class Test < Minitest::Test
  def test_part_one
    assert_equal 3, Solution::PartOne.new('1122').result
    assert_equal 4, Solution::PartOne.new('1111').result
    assert_equal 0, Solution::PartOne.new('1234').result
    assert_equal 9, Solution::PartOne.new('91212129').result
  end

  def test_part_two
    assert_equal 6, Solution::PartTwo.new('1212').result
    assert_equal 0, Solution::PartTwo.new('1221').result
    assert_equal 12, Solution::PartTwo.new('123123').result
    assert_equal 4, Solution::PartTwo.new('12131415').result
  end
end
