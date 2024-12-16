require_relative('../../lib/support')
require 'matrix'

EXAMPLE_RESULT = nil

class Solution
  attr_reader :input, :context

  def initialize(input:, context:)
    @input = input
    @context = context
  end

  def result
    width = context == :example ? 11 : 101
    height = context == :example ? 7 : 103

    bots = input.scan(/(-?\d+),(-?\d+)/).each_slice(2).map do |(pos, vel)|
      [Vector[*pos.map(&:to_i)], Vector[*vel.map(&:to_i)]]
    end

    10000.times do |i|
      grid = []
      height.times { grid << Array.new(width, '.') }

      bots.each do |bot|
        bot[0] += bot[1]
        grid[bot[0][1] % height][bot[0][0] % width] = '█'
      end

      next unless i > 7500

      system 'clear'

      grid.each_with_index do |row, y|
        row.each_with_index do |char, x|
          print "\n" if x % width == 0
          print char
        end
      end

      print "\nSeconds: #{i}\n"
      sleep 0.1
    end
  end
end

solve example: EXAMPLE_RESULT do |input, context|
  Solution.new(input:, context:).result
end
