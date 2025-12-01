require_relative('../../lib/support')

EXAMPLE_RESULT = 6

class Solution
  attr_reader :input

  def initialize(input:)
    @input = input
  end

  def result
    value = 50
    input.split.reduce(0) do |sum, line|
      dir = line[0] == 'L' ? -1 : 1
      amount = line[1..].to_i
      sum += amount / 100
      amount %= 100

      amount.times do
        value = (value + dir) % 100

        if value.zero?
          sum += 1
        elsif value.negative?
          value += 100
        end
      end

      sum
    end
  end
end

solve example: EXAMPLE_RESULT do |input|
  Solution.new(input:).result
end
