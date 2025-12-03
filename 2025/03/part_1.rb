require_relative('../../lib/support')

EXAMPLE_RESULT = 357

class Solution
  attr_reader :input

  def initialize(input:)
    @input = input
  end

  def result
    digits = 2
    banks = input.split.map { |bank| bank.chars.map(&:to_i) }
    banks.sum do |bank|
      start = 0

      digits.downto(1).map do |i|
        subset = bank[start..(bank.size - i)]
        subset.max.tap do |value|
          start += subset.index(value) + 1
        end
      end.join.to_i
    end
  end
end

solve example: EXAMPLE_RESULT do |input|
  Solution.new(input:).result
end
