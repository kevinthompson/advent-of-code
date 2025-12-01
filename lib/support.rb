require 'rainbow/refinement'
using Rainbow

def solve(example: nil)
  dir = File.dirname(caller_locations.first.path)

  unless example.nil?
    puts 'Running solution against example data...'.yellow
    result = yield(File.read("#{dir}/example.txt"), :example)

    if result == example
      puts 'Success!'.green
    else
      puts 'Error! Result does not match expected answer.'.red
      puts "Expected: #{example}"
      puts "Received: #{result}"
      return
    end
    puts "\n"
  end

  puts 'Running solution against input data...'.yellow
  puts "Result: #{yield(File.read("#{dir}/input.txt"), :input)}"
  puts "\n"
end

def draw_grid(grid)
  system 'clear'
  grid.chars.each_with_index do |char, i|
    print "\n" if i.positive? && (i % WIDTH).zero?
    case char
    when 'O' then print char.fg(:black).bg(:yellow)
    when 'X' then print char.fg(:aqua)
    when '#' then print char.fg(:white)
    else; print char.fg(:darkslategray)
    end
  end
  puts
end
