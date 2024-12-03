input = File.read(File.join(__dir__, 'input.txt'))
enabled = true
result = 0

input.scan(/((mul|do|don't)\((\d+),(\d+)\))/).each do |(_match, function, *args)|
  case function
  when 'mul'
    result += args[0].to_i * args[1].to_i if enabled
  when 'do', "don't"
    enabled = function == 'do'
  end
end

puts result
