require_relative('../../lib/support')

EXAMPLE_RESULT = 6

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
      sign = dir == "R" ? 1 : -1
      amount = line[1..-1].to_i
      amount.times do
        value = (value + sign) % 100

        if value == 0
          answer += 1
        elsif value < 0
          value += 100
        end
      end
    end

    answer
  end
end

solve example: EXAMPLE_RESULT do |input|
  Solution.new(input:).result
end