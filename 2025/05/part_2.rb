require_relative('../../lib/support')

EXAMPLE_RESULT = 14

class Solution
  attr_reader :input

  def initialize(input:)
    @input = input
  end

  def result
    range_input, _id_input = *input.split("\n\n")
    ranges = range_input.split.map do |range_string|
      Range.new(*range_string.split('-').map(&:to_i))
    end

    loop do
      changes = 0

      ranges.each do |range|
        (ranges.dup - [range]).each do |other|
          next unless range.overlap?(other)

          first = [range.first, other.first].min
          last = [range.last, other.last].max

          ranges.delete(range)
          ranges.delete(other)
          ranges << (first..last)

          changes += 1
          break
        end

        break if changes.positive?
      end

      break if changes.zero?
    end

    ranges.sum(&:size)
  end
end

solve example: EXAMPLE_RESULT do |input|
  Solution.new(input:).result
end
