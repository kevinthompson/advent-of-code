input = File.open('input.txt').read.strip
answer = input.lines.reduce(0) do |sum, line|
  result = 0
  values = line.split("\t").map(&:to_i)
  values.each do |value, index|
    values.each do |other_value|
      if value != other_value && value % other_value == 0
        result = value / other_value
      end
    end
  end

  sum += result
end

p answer
