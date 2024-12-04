require 'rainbow/refinement'
using Rainbow

class IncorrectSolution < StandardError
  def message; end
end

def solve(example: nil)
  dir = File.dirname(caller_locations.first.path)

  unless example.nil?
    puts 'Running solution against example data...'.yellow
    result = yield(File.read("#{dir}/example.txt"))

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
  puts "Result: #{yield(File.read("#{dir}/input.txt"))}"
  puts "\n"
end
