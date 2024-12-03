input = File.read(File.join(__dir__, 'input.txt'))
result = input.scan(/mul\((\d+),(\d+)\)/).reduce(0) do |memo, (a, b)|
  memo + a.to_i * b.to_i
end

puts result
