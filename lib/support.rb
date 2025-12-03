require 'benchmark'
require 'rainbow/refinement'
using Rainbow

def solve(example: nil)
  dir = File.dirname(caller_locations.first.path)

  unless example.nil?
    puts 'Running solution against example data...'.yellow
    result = nil
    time = Benchmark.realtime do
      result = yield(File.read("#{dir}/example.txt"), :example)
    end

    if result == example
      puts 'Success!'.green
      puts "#{(time * 1000).truncate(2)}ms"
    else
      puts 'Error! Result does not match expected answer.'.red
      puts "Expected: #{example}"
      puts "Received: #{result}"
      return
    end
    puts "\n"
  end

  puts 'Running solution against input data...'.yellow
  result = nil
  time = Benchmark.realtime do
    puts "#{'Answer:'.green} #{yield(File.read("#{dir}/input.txt"), :input)}"
  end
  puts "#{(time * 1000).truncate(2)}ms"
  puts "\n"
end
