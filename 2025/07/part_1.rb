require_relative('../../lib/support')
require 'matrix'

EXAMPLE_RESULT = 21

class Solution
  attr_reader :grid, :width, :splits

  def initialize(input:)
    @grid = input.gsub("\n", '')
    @width = input.split.first.size
    @splits = Set.new
  end

  def result
    walk_grid(pos: start, dir: [0, 1])
    splits.size
  end

  private

  def start
    @start ||= grid.chars.each_with_index do |char, i|
      return i if char == 'S'
    end
  end

  def walk_grid(pos:, dir:)
    grid[pos] = '|'
    step = pos + dir[1] * width + dir[0]
    char = grid[step]

    case char
    when '.'
      walk_grid(pos: step, dir:)
    when '^'
      @splits << step

      left = (step % width).zero? ? nil : step - 1
      right = ((step + 1) % width).zero? ? nil : step + 1

      walk_grid(pos: left, dir:)
      walk_grid(pos: right, dir:)
    end
  end
end

class Vector
  def x
    self[0]
  end

  def y
    self[1]
  end
end

solve example: EXAMPLE_RESULT do |input|
  Solution.new(input:).result
end
