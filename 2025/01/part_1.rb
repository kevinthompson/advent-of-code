require_relative('../../lib/support')

EXAMPLE_RESULT = 3

class Solution
  attr_reader :input

  def initialize(input:)
    @input = input
  end

  def result
    answer = 0
    value = 50

    lines = input.split
    lines.each do |line|
      dir = line[0]
      amount = line[1..].to_i
      amount *= -1 if dir == 'L'
      value += amount % 100
      value += 100 if value.negative?
      value -= 100 if value >= 100
      answer += 1 if value.zero?
    end

    answer
  end
end

solve example: EXAMPLE_RESULT do |input|
  Solution.new(input:).result
end
