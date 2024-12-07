INPUT = File.read("#{__dir__}/input.txt")
WIDTH = INPUT.lines.first.chomp.length
OFFSETS = [-WIDTH, 1, WIDTH, -1]

GRID = INPUT.gsub(/\n/, '')
START = GRID.index('^')

def walk_grid(grid, start: START, dir: 0, visited: {}, detect_loops: false)
  path = visited.dup
  index = start
  loop_indexes = []

  while (0...grid.length).include?(index) do
    return :loop if path[index].to_i & (1 << dir) > 0

    path[index] = path[index].to_i | (1 << dir)
    next_index = index + OFFSETS[dir]

    break if dir.odd? && next_index / WIDTH != index / WIDTH
    break if !(0...grid.length).include?(next_index)

    if grid[next_index] == '#'
      dir = (dir + 1) % 4
    else
      if detect_loops && next_index != START && !loop_indexes.include?(next_index) 
        loop_grid = grid.dup
        loop_grid[next_index] = '#'
        loop_indexes << next_index if walk_grid(loop_grid) == :loop
      end

      index = next_index
    end
  end

  loop_indexes.uniq.count
end

print "Result: #{walk_grid(GRID, detect_loops: true)}"
