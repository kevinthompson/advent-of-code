require_relative('../../lib/support')

solve example: 41 do |input|
  result = 1

  # build grid
  width = input.lines.first.gsub(/\n/, '').size
  height = input.lines.size
  grid = Array.new(height) { Array.new(width) }

  direction_symbols = %w[^ > v <]
  direction_offsets = [[0,-1], [1,0], [0,1], [-1,0]]

  current_x = nil
  current_y = nil
  current_dir_index = nil

  input.split("\n").each_with_index do |line, y|
    line.gsub(/\n/, '').split('').each_with_index do |char, x|
      if direction_symbols.include?(char)
        current_x = x
        current_y = y
        current_dir_index = direction_symbols.find_index(char)
        grid[y][x] = 'X'
      else
        grid[y][x] = char
      end

    end
  end

  # until x or y are invalid
  # move guard in current direction
  # if next space is obstacle, rotate direction
  dir = direction_offsets[current_dir_index]
  next_x = current_x + dir[0]
  next_y = current_y + dir[1]

  while next_x.between?(0,width - 1) && next_y.between?(0,height - 1) do
    char = grid[next_y][next_x]

    case char
    when '#'
      current_dir_index = (current_dir_index + 1) % direction_offsets.size
    when '.', 'X'
      current_x = next_x
      current_y = next_y

      if char == '.'
        grid[next_y][next_x] = 'X'
        result += 1
      end
    end

    dir = direction_offsets[current_dir_index]
    next_x = current_x + dir[0]
    next_y = current_y + dir[1]
  end

  result
end
