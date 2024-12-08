require_relative('../../lib/support')

solve example: 14 do |input|
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
      diff = b - a
      [a - diff, b + diff].each do |index|
        antinode_indexes << index if (0...grid.size).include?(index)
      end
    end
  end

  antinode_indexes.size
end
