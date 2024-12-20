require_relative '../../lib/support'
require 'matrix'

EXAMPLE_RESULT = 7036

module Direction
  UP = Vector[0, -1]
  RIGHT = Vector[1, 0]
  DOWN = Vector[0, 1]
  LEFT = Vector[-1, 0]
end

class Solution
  attr_reader :input, :grid, :goal, :start

  DIRECTIONS = [
    Direction::UP,
    Direction::RIGHT,
    Direction::DOWN,
    Direction::LEFT
  ]

  def initialize(input:)
    @input = input
    @grid = input.lines.map(&:chomp).map { |line| line.split('') }
    @grid.each_with_index do |row, y|
      row.each_with_index do |char, x|
        @start = [Vector[x, y], 1] if char == 'S'
        @goal = Vector[x, y] if char == 'E'
      end
    end

    @paths = []
  end

  def walk_path(path)
    return path if path.positions.last == goal

    DIRECTIONS.each do |direction|
      case direction
      when path.direction
        path.score += 1
      when path.direction * -1
        :noop
      else
        path.score += 1000
        path.direction = direction
      end
    end

    while reindeer[0] != goal do
      next_position = reindeer[0] + DIRECTIONS[reindeer[1]]

      case grid.dig(*next_position.to_a.reverse)
      when '.'
        grid[reindeer[0][1]][reindeer[0][0]] = '.'
        grid[next_position[1]][next_position[0]] = 'R'
        reindeer[0] = next_position
      when '#'
        reindeer[1] = (reindeer[1] + 1) % 4
      end

      system 'clear'

      grid.each_with_index do |row, y|
        row.each_with_index do |char, x|
          print "\n" if x % row.size == 0
          print char
        end
      end
    end
  end

  def result
    paths = walk_path(Path.new(positions: [start]))
  end
end

class Path
  attr_reader :positions
  attr_accessor :direction, :score

  def initialize(positions: [], direction: Direction::RIGHT, score: 0)
    @positions = positions
    @direction = direction
    @score = score
  end

  def dup
    self.class.new(positions: positions.dup, direction:, score:)
  end
end

solve example: EXAMPLE_RESULT do |input|
  Solution.new(input:).result
end
