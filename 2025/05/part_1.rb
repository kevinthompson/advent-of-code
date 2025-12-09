require_relative('../../lib/support')

EXAMPLE_RESULT = 3

class Solution
  attr_reader :input

  def initialize(input:)
    @input = input
  end

  def result
    range_input, id_input = *input.split("\n\n")
    ids = id_input.split.map(&:to_i)
    ranges = range_input.split.map do |range_string|
      values = range_string.split('-').map(&:to_i)
      values.first..values.last
    end

    ids.count do |id|
      ranges.any? do |range|
        range.include?(id)
      end
    end
  end
end

solve example: EXAMPLE_RESULT do |input|
  Solution.new(input:).result
end
