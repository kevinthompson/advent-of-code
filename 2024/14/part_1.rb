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
    width = context == :input ? 101 : 11
    height = context == :input ? 103 : 7
    grid_size = width * height

    bots = input.scan(/(-?\d+),(-?\d+)/).each_slice(2).map do |(pos, vel)|
      [Vector[*pos.map(&:to_i)], Vector[*vel.map(&:to_i)]]
    end

    100.times do
      bots.each do |bot|
        pos = bot[0] + bot[1]
        bot[0] = Vector[pos[0] % width, pos[1] % height]
      end
    end
    
    quadrants = [0,0,0,0]

    xmid = width/2
    ymid = height/2

    bots.each do |bot|
      x = bot[0][0]
      y = bot[0][1]

      if y < ymid
        if x < xmid
          quadrants[0] += 1
        elsif x > xmid
          quadrants[1] += 1
        end
      elsif y > ymid
        if x < xmid
          quadrants[2] += 1
        elsif x > xmid
          quadrants[3] += 1
        end
      end
    end

    quadrants.reduce(:*)
  end
end

solve example: EXAMPLE_RESULT do |input, context|
  Solution.new(input:, context:).result
end
