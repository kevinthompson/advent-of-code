require 'matrix'
require_relative('../../lib/support')

solve example: 34 do |input|
  width = input.lines.first.chomp.length
  grid = input.gsub(/\n/,'')
  antenna_indexes = {}
  antinode_positions = Set.new

  grid.chars.each_with_index do |char, index|
    if char != '.'
      antenna_indexes[char] ||= []
      antenna_indexes[char] << index 
    end
  end

  antenna_indexes.each_value do |indexes|
    next if indexes.size < 2

    indexes.combination(2).each do |(a, b)|
      v1 = Vector[a % width, a / width]
      v2 = Vector[b % width, b / width]
      diff = v2 - v1

      [[v1, :-], [v2, :+]].each do |(position, operation)|
        while((0...width).include?(position[0]) && (0...input.lines.size).include?(position[1])) do
          antinode_positions << position 
          position = position.send(operation, diff)
        end
      end
    end
  end

  antinode_positions.size
end
