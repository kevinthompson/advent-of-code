input = File.read(File.join(__dir__, 'input.txt'))

print input
  .split("\n")
  .map(&:split)
  .transpose
  .map(&:sort)
  .transpose
  .flatten
  .map(&:to_i)
  .each_slice(2)
  .reduce(0) { |memo, (a, b)| memo + (a - b).abs }
