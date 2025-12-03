require_relative('../../lib/support')

EXAMPLE_RESULT = 3121910778619

class Solution
  attr_reader :input

  def initialize(input:)
    @input = input
  end

  def result
    banks = input.split.map { |bank| bank.chars.map(&:to_i) }
    banks.map do |bank|
      start = 0

      12.downto(1).map do |i|
        subset = bank[start..(bank.size - i)]
        subset.max.tap do |value|
          start += subset.index(value) + 1
        end
      end.join.to_i
    end.sum
  end
end

solve example: EXAMPLE_RESULT do |input|
  Solution.new(input:).result
end
