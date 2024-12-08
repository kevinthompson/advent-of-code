require 'matrix'
require_relative('../../lib/support')

solve example: 14 do |input|
  width = input.lines.first.chomp.length
  grid = input.gsub(/\n/,'')
  antenna_char_indexes = {}
  antinode_indexes = Set.new

  grid.chars.each_with_index do |char, index|
    if char != '.'
      antenna_char_indexes[char] ||= []
      antenna_char_indexes[char] << index 
    end
  end

  antenna_char_indexes.each do |char, indexes|
    next if indexes.size < 2

    indexes.permutation(2).map(&:sort).uniq.each do |(a, b)|
      v1 = Vector[a % width, a / width]
      v2 = Vector[b % width, b / width]
      diff = v2 - v1

      [v1 - diff, v2 + diff].each do |position|
        if (0...width).include?(position[0]) && (0...input.lines.size).include?(position[1])
          index = position[1] * width + position[0]
          antinode_indexes << index 
        end
      end
    end
  end

  antinode_indexes.size
end
