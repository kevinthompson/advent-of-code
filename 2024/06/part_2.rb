INPUT = File.read("#{__dir__}/example.txt")
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
    system "clear"
    grid.chars.each_with_index do |char, i|
      print "\n" if i % WIDTH == 0
      print char
    end
    sleep 0.2

    # detect loop
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
      next_index = index + OFFSETS[dir] 
    end

    if detect_loops && next_index != START
      loop_grid = grid.dup
      loop_grid[next_index] = '#'
      if walk_grid(loop_grid, start: index, visited: path, dir:) == 1
        loops += 1
      end
    end

    # detect loop
    if path[next_index].to_i & (1 << dir) > 0
      return 1
    end

    index = next_index
  end

  loops
end

print "Result: #{walk_grid(GRID, detect_loops: true)}"
