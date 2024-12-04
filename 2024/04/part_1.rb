require_relative('../../lib/support')

solve example: 18 do |input|
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
  (0...height).each do |y|
    (0...width).each do |x|

      if grid.dig(y, x) == 'X'
        (-1..1).each do |oy|
          (-1..1).each do |ox|
            next if ox.zero? && oy.zero?

            result += 1 if %w[M A S].each_with_index.all? do |letter, i|
              gx = x + ox * (i + 1)
              gy = y + oy * (i + 1)
              gx.between?(0,width) && gy.between?(0,height) && grid.dig(gy, gx) == letter
            end
          end
        end
      end
    end
  end

  result
end
