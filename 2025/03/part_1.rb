require_relative('../../lib/support')

EXAMPLE_RESULT = 357

class Solution
  attr_reader :input

  def initialize(input:)
    @input = input
  end

  def result
    input.split.map do |bank|
      ibank = bank.chars.map(&:to_i)
      tens = ibank[0..-2].max
      tens_index = ibank.index(tens)
      ones = ibank[(tens_index + 1)..-1].max
      [tens, ones].join.to_i
    end.sum
  end
end

solve example: EXAMPLE_RESULT do |input|
  Solution.new(input:).result
end
