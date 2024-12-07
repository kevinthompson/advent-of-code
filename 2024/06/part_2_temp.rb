require_relative '../../lib/support.rb'

EXPECTATION = 6

class PartTwo < Solution
  attr_accessor :count
  attr_reader :width, :height, :directions, :grid, :start_index, :visited

  def result
    @count = 0

    build_grid

    current_index = start_index
    dir_index = 0

    dir = directions[dir_index]
    next_index = current_index + dir

    while (0...grid.size).include?(next_index)
      char = grid[next_index]

      if char == '#'
        dir_index = (dir_index + 1) % directions.size
        dir = directions[dir_index]
      else
        current_index = next_index
        visited << current_index
      end

      next_index = current_index + dir

      if dir == -1 && current_index % width == 0 || dir == 1 && next_index % width == 0
        break
      end
    end

    obstacle_indexes = visited.uniq - [start_index]
    obstacle_indexes.each do |index|
      temp_grid = grid.dup
      temp_grid[index] = '#'

      current_index = start_index
      dir_index = 0
      dir = directions[dir_index]
      next_index = current_index + dir
      visited = [[start_index, dir]]

      while (0...grid.size).include?(next_index)
        char = temp_grid[next_index]

        # step through grid
        case char
        when '#'
          dir_index = (dir_index + 1) % directions.size
          dir = directions[dir_index]
        else
          if visited.include?([next_index, dir])
            result += 1
            break
          else
            current_index = next_index
            visited << [current_index, dir]
          end
        end

        next_index = current_index + dir

        if dir == -1 && current_index % width == 0 || dir == 1 && next_index % width == 0
          break
        end
      end
    end

    result
  end

  private

  def build_grid
    @width = input.lines.first.gsub(/\n/, '').size
    @height = input.lines.size
    @directions = [-width, 1, width, -1]
    @grid = input.gsub("\n")
    @visited = []

    input.split("\n").each_with_index do |line, y|
      line.gsub(/\n/, '').split('').each_with_index do |char, x|
        index = (y * width) + x

        if char == '^'
          @start_index = index
          visited << index
        end

        grid[index] = char
      end
    end
  end
end

solve(
  solution: PartTwo, 
  example: File.read("#{__dir__}/example.txt"), 
  expectation: EXPECTATION, 
  input: File.read("#{__dir__}/input.txt")
)
