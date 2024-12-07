require 'rainbow/refinement'
using Rainbow

class Solution
  attr_reader :input

  def initialize(input:)
    @input = input
    after_initialize
  end

  def after_initialize
    :noop
  end

  def result
    raise NotImplementedError 
  end
end

def solve(solution:, example:, expectation:, input:)
  puts 'Running solution against example data...'.yellow
  result = solution.new(input: example).result

  if result == expectation
    puts 'Success!'.green
  else
    puts 'Error! Result does not match expected answer.'.red
    puts "Expected: #{expectation}"
    puts "Received: #{result}"
    return
  end
  puts "\n"

  puts 'Running solution against input data...'.yellow
  puts "Result: #{solution.new(input:).result}"
  puts "\n"
end
