require_relative('../../lib/support')

EXAMPLE_RESULT = 1206
DIRECTIONS = [[0,-1],[1,0],[0,1],[-1,0]]

class Solution
  attr_reader :grid, :input

  def initialize(input:)
    @input = input
  end

  def score(char, x, y)
    directions = DIRECTIONS.dup
    area = 1
    perimeter = 0
    grid[y][x] = "-#{char}"

    while directions.size > 0 do
      ox, oy = directions.pop
      nx = x + ox
      ny = y + oy
      neighbor = nil

      if nx.between?(0, grid[0].size - 1) && ny.between?(0,grid.size - 1)
        neighbor = grid.dig(ny,nx)
      end

      if neighbor == char
        next_area, next_perimeter = score(char, nx, ny)
        area += next_area
        perimeter += next_perimeter
      elsif neighbor != "-#{char}"
        perimeter += 1
      end
    end

    [area, perimeter]
  end

  def call
    result = 0

    @grid = input.lines.map(&:chomp).map { |line| line.split('') }
    @grid.each_with_index do |line, y|
      line.each_with_index do |char, x|
        if char != nil && char[0] != '-'
          area, perimeter = score(char, x, y)
          result += area * perimeter
        end
      end
    end

    result
  end
end

# Run solution against example and input
solve example: EXAMPLE_RESULT do |input|
  Solution.new(input:).call
end
