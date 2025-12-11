require_relative('../../lib/support')

EXAMPLE_RESULT = 4277556

class Solution
  attr_reader :input

  def initialize(input:)
    @input = input
  end

  def result
    lines = input.lines.map do |line|
      line.scan(/[\d+*-]+/)
    end

    lines.transpose.sum do |values|
      operator = values.pop
      values.map(&:to_i).reduce(&operator.strip.to_sym)
    end
  end
end

solve example: EXAMPLE_RESULT do |input|
  Solution.new(input:).result
end
