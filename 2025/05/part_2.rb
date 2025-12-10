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
      new_ranges = Set.new

      ranges.each do |range|
        overlapping = false

        ranges.each do |other|
          next if range == other
          next unless range.overlap?(other)

          overlapping = true
          first = [range.first, other.first].min
          last = [range.last, other.last].max
          new_ranges << Range.new(first, last)
          break
        end

        new_ranges << range unless overlapping
      end

      break if new_ranges.size == ranges.size

      ranges = new_ranges
    end

    ranges.sum(&:size)
  end
end

solve example: EXAMPLE_RESULT do |input|
  Solution.new(input:).result
end
