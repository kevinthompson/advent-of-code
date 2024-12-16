require_relative('../../lib/support')
require 'matrix'

EXAMPLE_RESULT = 12

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

    100.times do
      bots.each do |bot|
        bot[0] += bot[1]
      end
    end
    
    quadrants = [0,0,0,0]

    xmid = width/2
    ymid = height/2

    bots.each do |bot|
      x = bot[0][0] % width
      y = bot[0][1] % height

      quadrants[0] += 1 if y < ymid && x < xmid
      quadrants[1] += 1 if y < ymid && x > xmid
      quadrants[2] += 1 if y > ymid && x < xmid
      quadrants[3] += 1 if y > ymid && x > xmid
    end

    quadrants.reduce(:*)
  end
end

solve example: EXAMPLE_RESULT do |input, context|
  Solution.new(input:, context:).result
end
