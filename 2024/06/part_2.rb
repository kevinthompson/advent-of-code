require_relative '../../lib/support'

INPUT = File.read("#{__dir__}/input.txt")
LINES = INPUT.lines

WIDTH = LINES.first.chomp.length
OFFSETS = [-WIDTH, 1, WIDTH, -1]

GRID = INPUT.gsub(/\n/, '')
START = GRID.index('^')

def walk_grid(grid, start: START, dir: 0, visited: {}, detect_loops: false)
  path = visited.dup
  index = start
  loop_indexes = []

  while (0...grid.length).include?(index) do
    # record direction
    path[index] ||= 0
    path[index] |= (1 << dir)

    # get next index
    next_index = index + OFFSETS[dir]

    # detect index out of bounds
    break if dir.odd? && next_index / WIDTH != index / WIDTH
    break if !(0...grid.length).include?(next_index)

    # detect obstruction
    while grid[next_index] == '#'
      dir = (dir + 1) % 4
      path[index] |= (1 << dir)
      next_index = index + OFFSETS[dir]
    end

    # place new obstacle and walk grid
    if detect_loops && next_index != START
      loop_grid = grid.dup
      loop_grid[next_index] = '#'

      if !loop_indexes.include?(next_index) 
        if walk_grid(loop_grid, start: index, visited: path, dir:) == :loop
          loop_indexes << next_index
        end
      end
    end

    # detect loop
    return :loop if path[next_index].to_i & (1 << dir) > 0

    # move to next index
    index = next_index
  end

  loop_indexes.uniq.count
end

print "Result: #{walk_grid(GRID, detect_loops: true)}"
