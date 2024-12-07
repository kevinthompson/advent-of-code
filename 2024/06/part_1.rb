input = File.read("#{__dir__}/example.txt")
lines = input.lines
result = 0

WIDTH = lines.first.gsub(/\n/,'').strip.length
OFFSETS = [-WIDTH, 1, WIDTH, -1]

GRID = input.gsub(/\n/, '')
START_INDEX = GRID.index('^')

def walk_grid(grid)
  index = START_INDEX
  dir = 0
  visited = {}

  while (0...grid.length).include?(index) do
    visited[index] ||= 0
    visited[index] |= (1 << dir)

    break if dir == 3 && index % WIDTH == 0
    break if dir == 1 && (index + 1) % WIDTH == 0

    next_index = index + OFFSETS[dir]

    if grid[next_index] == '#'
      dir = (dir + 1) % 4
    else
      index = next_index
    end

    yield(visited, next_index, dir) if block_given?
  end

  return visited
end

visited = walk_grid(GRID)
p visited.keys.count
