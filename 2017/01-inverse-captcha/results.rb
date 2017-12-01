require_relative 'solution/part_one'
require_relative 'solution/part_two'

input = File.open('input.txt').read
solution = Solution.new(input)
solution.results.each { |result| print "#{result}\n" }
