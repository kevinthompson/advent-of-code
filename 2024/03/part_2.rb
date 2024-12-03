input = File.read(File.join(__dir__, 'input.txt'))
enabled = true
result = 0

input.scan(/(mul|do|don't)\(((?:,?\d+)*)\)/).each do |(function, args)|
  case function
  when 'mul'
    result += args.split(',').map(&:to_i).reduce(:*) if enabled
  when 'do', "don't"
    enabled = function == 'do'
  end
end

puts result
