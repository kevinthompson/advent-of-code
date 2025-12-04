require_relative('../../lib/support')

EXAMPLE_RESULT = 13

class Solution
  attr_reader :input, :grid

  def initialize(input:)
    @input = input
    @grid = input.split.map { |row| row.split("") }
  end

  def result
    width = grid[0].size
    height = grid.size
    valid = 0

    height.times do |y|
      width.times do |x|
        next unless grid[y][x] == '@'

        valid += 1 if valid?(x, y)
      end
    end

    valid
  end

  def valid?(x,y)
    rolls = 0

    (-1..1).each do |oy|
      (-1..1).each do |ox|
        next if ox.zero? && oy.zero?

        nx = x + ox
        ny = y + oy

        next if ny.negative? || ny >= grid.size || nx.negative? || nx >= grid[0].size

        rolls += 1 if grid[ny][nx] == '@'
        return false if rolls >= 4
      end
    end

    rolls < 4
  end
end

solve example: EXAMPLE_RESULT do |input|
  Solution.new(input:).result
end
