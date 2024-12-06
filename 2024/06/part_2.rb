require_relative('../../lib/support')

solve example: 6 do |input|
  result = 0

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
        grid[y][x] = direction_symbols[current_dir_index]
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

  while next_x.between?(0,width - 1) && next_y.between?(0,height - 1)
    char = grid[next_y][next_x]

    # check for obstacle placement
    rot_index = (current_dir_index + 1) % 4
    rot_symbol = direction_symbols[rot_index]
    rot_dir = direction_offsets[rot_index]

    check_x = current_x + rot_dir[0]
    check_y = current_y + rot_dir[1]

    while check_x.between?(0,width - 1) && check_y.between?(0,height - 1) do
      other_char = grid[check_y][check_x] 
      case other_char
      when '#'
        break
      when rot_symbol
        result += 1
        grid[next_y][next_x] = 'O'
        char = 'O'
        break
      end

      check_x += rot_dir[0]
      check_y += rot_dir[1]
    end

    # step through grid
    if char == '#'
      current_dir_index = (current_dir_index + 1) % direction_offsets.size
      dir = direction_offsets[current_dir_index]
      next_x = current_x + dir[0]
      next_y = current_y + dir[1]
      char = grid[next_y][next_x]
    end

    current_x = next_x
    current_y = next_y

    if char == '.'
      grid[next_y][next_x] = direction_symbols[current_dir_index]
    end

    dir = direction_offsets[current_dir_index]
    next_x = current_x + dir[0]
    next_y = current_y + dir[1]
    
    if input.lines.size < 20
      puts ''
      grid.each do |row|
        puts row.join
      end

      sleep 1
    end
  end

  result
end
