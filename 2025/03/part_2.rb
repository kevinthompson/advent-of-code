require_relative('../../lib/support')

EXAMPLE_RESULT = 3121910778619

class Solution
  attr_reader :input

  def initialize(input:)
    @input = input
  end

  def result
    input.split.map do |bank|
      ibank = bank.chars.map(&:to_i)
      bsize = ibank.size
      start = 0

      12.times.map do |i|
        offset = bsize - 12 + i
        subset = ibank[start..offset]
        value = subset.max
        start += subset.index(value) + 1
        value
      end.join.to_i
    end.sum
  end
end

solve example: EXAMPLE_RESULT do |input|
  Solution.new(input:).result
end
