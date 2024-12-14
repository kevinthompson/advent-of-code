require_relative('../../lib/support')

EXAMPLE_RESULT = 1206
DIRECTIONS = [[0,-1],[1,0],[0,1],[-1,0]]
CORNER_POSITIONS = [[-1,-1],[1,-1],[1,1],[-1,1]]

class Solution
  attr_reader :grid

  def initialize(input:)
    height = input.lines.size
    width = input.lines.first.chomp.size
    @grid = input.lines.map(&:chomp).map { |line| line.split('') }
  end

  def call
    grid.each_with_index.sum do |line, y|
      line.each_with_index.sum do |char, x|
        area, corners = measure([x, y])
        area * corners
      end
    end
  end

  private

  def measure(position)
    char = grid.dig(*position.reverse)
    return [0, 0] if char.nil? || char[0] == '-'
    
    area = 1
    corners = count_corners(char, position)
    grid[position[1]][position[0]] = "-#{char}"

    DIRECTIONS.each do |direction|
      new_position = position.zip(direction).map(&:sum)

      if match?(char, position, direction)
        next_area, next_corners = measure(new_position)
        area += next_area
        corners += next_corners
      end
    end

    [area, corners]
  end

  def count_corners(char, position)
    DIRECTIONS.each_with_index.sum do |direction, index|
      adjacent = [direction, DIRECTIONS[index-1]]
      diagonal = CORNER_POSITIONS[index]
      match = proc { |offset| match?(char, position, offset) }
      adjacent.none?(&match) || (adjacent.all?(&match) && !match.call(diagonal)) ? 1 : 0
    end
  end

  def match?(char, position, offset)
    new_position = offset.zip(position).map(&:sum)
    valid?(new_position) && [char, "-#{char}"].include?(grid.dig(*new_position.reverse))
  end

  def valid?(position)
    position[0].between?(0, grid[0].size - 1) && position[1].between?(0, grid.size - 1)
  end
end

# Run solution against example and input
solve example: EXAMPLE_RESULT do |input|
  Solution.new(input:).call
end
