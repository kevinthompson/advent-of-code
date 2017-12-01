Dir[File.expand_path(File.dirname(__FILE__)) + '/solution/*.rb'].each { |file| require file }
input = File.open('input.txt').read
solution = Solution.new(input)
solution.results.each { |result| print "#{result}\n" }
