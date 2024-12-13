require_relative('../../lib/support')

EXAMPLE_RESULT = 1930
DIRECTIONS = [[0,-1],[1,0],[0,1],[-1,0]]

class Solution
  attr_reader :grid

  def initialize(input:)
    @grid = input.lines.map(&:chomp).map { |line| line.split('') }
  end

  def call
    result = 0

    grid.each_with_index do |line, y|
      line.each_with_index do |char, x|
        area, perimeter = score(x, y)
        result += area * perimeter
      end
    end

    result
  end

  private

  def score(x, y)
    char = grid.dig(y, x)
    return [0, 0] if char.nil? || char[0] == '-'
    
    area = 1
    perimeter = 0
    grid[y][x] = "-#{char}"

    DIRECTIONS.dup.each do |(ox, oy)|
      nx = x + ox
      ny = y + oy

      neighbor = valid?(nx, ny) ? grid.dig(ny,nx) : nil

      if neighbor == char
        next_area, next_perimeter = score(nx, ny)
        area += next_area
        perimeter += next_perimeter
      elsif neighbor != "-#{char}"
        perimeter += 1
      end
    end

    [area, perimeter]
  end

  def valid?(x, y)
    x.between?(0, grid[0].size - 1) && y.between?(0, grid.size - 1)
  end
end

# Run solution against example and input
solve example: EXAMPLE_RESULT do |input|
  Solution.new(input:).call
end
