require_relative('../../lib/support')

solve example: 9 do |input|
  result = 0

  # build grid
  width = input.lines.first.gsub(/\n/, '').size
  height = input.lines.size
  grid = Array.new(height) { Array.new(width) }

  input.split("\n").each_with_index do |line, y|
    line.gsub(/\n/, '').split('').each_with_index do |char, x|
      grid[y][x] = char
    end
  end

  # check each character
  (1...height - 1).each do |y|
    (1...width - 1).each do |x|

      if grid.dig(y, x) == 'A'
        letters = []

        [[-1,-1], [1,-1], [1,1], [-1,1]].each do |(ox, oy)|
          gx = x + ox
          gy = y + oy

          if gx.between?(0,width) && gy.between?(0,height)
            letters << grid.dig(gy, gx)
          end
        end

        result += 1 if letters.count('S') == 2 && letters.count('M') == 2 && !letters.join.include?('SMS')
      end
    end
  end

  result
end
