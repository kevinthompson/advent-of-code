INPUT = File.read("#{__dir__}/input.txt")
LINES = INPUT.lines

WIDTH = LINES.first.gsub(/\n/,'').strip.length
OFFSETS = [-WIDTH, 1, WIDTH, -1]

GRID = INPUT.gsub(/\n/, '')
START_INDEX = GRID.index('^')

result = 0

def walk_grid(grid)
  index = START_INDEX
  dir = 0
  visited = {}

  while (0...grid.length).include?(index) do
    visited[index] ||= 0
    visited[index] |= (1 << dir)
    next_index = index + OFFSETS[dir]
    break if dir.odd? && next_index / WIDTH != index / WIDTH

    if grid[next_index] == '#'
      dir = (dir + 1) % 4
    else
      index = next_index
    end

    yield(visited, index, dir) if block_given?
  end

  visited
end

visited = walk_grid(GRID)
blockable_indexes = (visited.keys - [START_INDEX]).uniq
blockable_indexes.each do |blockable_index|
  blocked_grid = GRID.dup
  blocked_grid[blockable_index] = '#'
  walk_grid(blocked_grid) do |visited, index, dir|
    if visited[index].to_i & (1 << dir) > 0
      result += 1
      break
    end
  end
end

print "Result: #{result}"
