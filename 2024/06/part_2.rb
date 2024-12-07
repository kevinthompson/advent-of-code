INPUT = File.read("#{__dir__}/input.txt")
LINES = INPUT.lines

WIDTH = LINES.first.gsub(/\n/,'').strip.length
OFFSETS = [-WIDTH, 1, WIDTH, -1]

GRID = INPUT.gsub(/\n/, '')
START = GRID.index('^')

def walk_grid(grid, start: START, dir: 0, visited: {}, detect_loops: false)
  path = visited.dup
  index = start
  loops = 0

  while (0...grid.length).include?(index) do
    path[index] ||= 0
    path[index] |= (1 << dir)
    next_index = index + OFFSETS[dir]

    break if dir.odd? && next_index / WIDTH != index / WIDTH
    break if !(0...grid.length).include?(next_index)

    if grid[next_index] == '#'
      dir = (dir + 1) % 4
    else
      if detect_loops && next_index != START
        loop_grid = grid.dup
        loop_grid[next_index] = '#'
        loops += walk_grid(loop_grid, start: index, visited: path, dir:)
      end

      index = next_index
    end

    if path[index].to_i & (1 << dir) > 0
      return 1
    end
  end

  loops
end

print "Result: #{walk_grid(GRID, detect_loops: true)}"
