DIRECTIONS = [[0,-1],[1,0],[0,1],[-1,0]]

input = File.read("#{__dir__}/input.txt")
count = 0

# build grid
WIDTH = input.lines.first.chomp.size
HEIGHT = input.lines.size
GRID = Array.new(HEIGHT) { Array.new(WIDTH) }

input.split("\n").each_with_index do |line, y|
  line.gsub(/\n/, '').split('').each_with_index do |char, x|
    GRID[y][x] = char.to_i
  end
end

def walk_neighbors(number, x, y)
  neighbors = DIRECTIONS.dup
  summits = Set.new

  while neighbors.size > 0 do
    ox, oy = neighbors.pop
    nx = x + ox
    ny = y + oy
    next unless nx.between?(0, WIDTH) && ny.between?(0, HEIGHT)

    neighbor = GRID.dig(ny, nx)
    if neighbor == number + 1
      if neighbor == 9
        summits << [nx,ny]
      else
        summits += walk_neighbors(number + 1, nx, ny) 
      end
    end
  end

  summits
end

# check each character
(0...HEIGHT).each do |y|
  (0...WIDTH).each do |x|
    if GRID.dig(y, x) == 0
      count += walk_neighbors(0, x, y).count
    end
  end
end

p count
